require 'securerandom'

class Api::V1::UsersController < Api::V1::BaseController
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

    @cred = EphemeralCredential.new()
    # TODO - Need to generate the username based on timestamp and recvd user id?
    @cred.username = SecureRandom.base64(16).gsub(/=+$/, '')
    # TODO - generate the password random? or use hmac?
    @cred.secret = SecureRandom.base64(16).gsub(/=+$/, '')
    @cred.user_id = @user.id;
    if @cred.save
        render :json => @cred.as_json(:only => [:username, :secret], 
                                      :methods => [:ttl, :uris])
    else
        render :json => { :errors => "Request rejected." }
        logger.debug @cred.errors.full_messages
    end

  end
end