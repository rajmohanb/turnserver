class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def show
    @user = current_user
  end

  def index
    @user = User.find(params[:id]);
  end

  def create
    @user = User.new(params[:user]);
    @user.email = @user.first_name + "@tt.com" #temp fix for development
    @user.password = @user.last_name #temp fix for development
    @user.customer_id = params[:customer_id]
    if @user.save
        flash[:notice] = "User account successfully created"
        render action: "index"
    else
        logger.debug @user.errors.full_messages
        flash[:notice] = "User account creation did not go through"
        render action: "new"
    end
    #redirect_to action: show
  end

  def destroy
  end
end
