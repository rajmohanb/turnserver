require 'securerandom'

class Api::V1::UsersController < Api::V1::BaseController

  before_filter :cors_preflight_check
  after_filter :cors_set_access_control_headers #, :only => [:get_credentials]

  def index
    respond_with(current_customer.users, :only => [:first_name, :last_name, 
                 :active_allocs, :allocs, :bandwidth_used, :email])
  end

  def get_credentials
    @user = User.find_by_email(params[:email]);
    unless @user
      render :json => { :errors => "Invalid user account." }
      return
    end

    Rails.logger.info(request.env)

    @cred = EphemeralCredential.new()
    # TODO - Need to generate the username based on timestamp and recvd user id?
    @cred.username = SecureRandom.base64(16).gsub(/=+$/, '')
    # TODO - generate the password random? or use hmac?
    @cred.secret = SecureRandom.base64(16).gsub(/=+$/, '')
    @cred.user_id = @user.id;
    logger.debug "Received get credentials for user: #{@user.first_name} and id: #{@cred.user_id}"
    if @cred.save
        render :json => @cred.as_json(:only => [:username, :secret], 
                                      :methods => [:ttl, :uris])
    else
        render :json => { :errors => "Request rejected." }
        logger.debug @cred.errors.full_messages
    end

  end

  # if this is a preflight OPTIONS request, then short-circuit the request,
  # return only the necessary headers and return an empty text/plain.
  def  cors_preflight_check
    if request.method == :options
      logger.error 'In cors_preflight_check'
      Rails.logger.info(request.env)
      cors_set_access_control_headers 
      head :ok
    end
  end

  def options
    logger.error 'In options action handler'
    render text: ''
  end


  private
  # For all responses in this controller, return the CORS access control headers.
  def cors_set_access_control_headers
    logger.error 'In cors_set_access_control_headers'
    headers['Access-Control-Allow-Origin'] = request.env['HTTP_ORIGIN']
    headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
    # headers['Access-Control-Request-Method'] = '*'
    #headers['Access-Control-Allow-Headers'] = request.headers['Content-Type'] if request.headers['Content-Type']
    headers['Access-Control-Allow-Headers'] = 'Content-Type'
    headers['Access-Control-Max-Age'] = "1000"
  end


  #def set_access_control_headers
  #  headers['Access-Control-Allow-Origin'] = '*'
  #  headers['Access-Control-Allow-Methods'] = 'POST, OPTIONS'
  #  # headers['Access-Control-Allow-Headers'] = 
  #  headers['Access-Control-Max-Age'] = '1728000'
  #  #render :text => '', :content_type => 'text/plain'
  #end
end
