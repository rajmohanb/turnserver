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
      @current_customer = Customer.find_by_authentication_token(params[:token])
      unless @current_customer
        # respond_with({:error => "Token is invalid." })
        render :json => { :errors => "Authentication failed." }
        return
      end
    end

    def current_customer
      @current_customer
    end
end
