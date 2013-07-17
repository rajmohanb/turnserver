class Api::V1::UsersController < Api::V1::BaseController
  def index
    respond_with(current_customer.users, :only => [:first_name, :last_name, 
                 :active_allocs, :allocs, :bandwidth_used, :email])
  end

  def get_credentials
    @user = User.find_by_email(params[:email]);
    unless @user
      # respond_with({ :error => "Invalid user." })
      render :json => { :errors => "Invalid user account." }
      return
    end
    
    render :json => @user.as_json(:only => [:turn_username, :turn_secret])
  end
end
