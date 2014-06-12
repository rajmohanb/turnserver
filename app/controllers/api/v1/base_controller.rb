class Api::V1::BaseController < ActionController::Base
  respond_to :json, :xml
  before_filter :authenticate_customer

  private
    def authenticate_customer
      unless (params[:service] == 'turn')
        #respond_with({:error => "unknown service." })
        render :json => { :errors => "Unknown service." }
        return
      end

      # TODO - since we moved to devise 3.1+, token_authenticatable feature was
      # removed from devise gem and it was suggested that the devise user roll
      # out his own implementation. Accordingly, now we generate the 
      # authentication_token ourselves in the model. However, it was advised
      # that during authentication we should not use 'find_by_authentication_token'
      # directrly as it is succeptible to timing attacks. So it was suggested to
      # use some additional parameter such as email and use secure compare.
      #
      # As of now here, we have not implemented the same and are still
      # directly using 'find_by_authentication_token'. But we need to change
      # this sometime later.
      # ref 1 - https://gist.github.com/josevalim/fb706b1e933ef01e4fb6
      # ref 2 - http://stackoverflow.com/questions/18605294/is-devises-token-authenticatable-secure
      # ref 3 - http://www.soryy.com/ruby/api/rails/authentication/2014/03/16/apis-with-devise.html
      # ref 4 - http://blog.plataformatec.com.br/2013/08/devise-3-1-now-with-more-secure-defaults/

      @current_customer = Customer.find_by_authentication_token(params[:token])
      unless @current_customer
        # respond_with({:error => "Token is invalid." })
        render :json => { :errors => "Authentication failed." }
        return
      end

      # ACL - check the CORS Origin header 
      Rails.logger.error("The received CORS ORIGIN header value in request: ")
      Rails.logger.info(request.env["HTTP_ORIGIN"])
      Rails.logger.error(@current_customer.webapp_url)
      unless (request.env['HTTP_ORIGIN'] == @current_customer.webapp_url)
        Rails.logger.error("The ORIGIN header is invalid, hence rejecting the request")
        render :json => { :errors => "Forbidden!" }
        return
      end
    end

    def current_customer
      @current_customer
    end
end
