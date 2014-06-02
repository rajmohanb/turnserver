require 'securerandom'

class UsersController < ApplicationController

  before_filter :authenticate_customer!

  def new
    @user = User.new
  end

  def show
    @user = User.find(params[:id]);
  end

  def index
    @user = User.find(params[:id]);
  end

  def edit
    @user = User.find(params[:id]);
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(params[:user])
      # handle a successful update
      flash[:success] = "Profile updated"
      redirect_to customer_user_path(@user.customer_id, @user)
    else
      # print the errors to the development log
      Rails.logger.info(@user.errors.messages.inspect)
      flash[:error] = "Something wrong? Profile NOT updated"
      render 'edit'
    end
  end

  def create
    @user = User.new(params[:user]);
    #@user.email = @user.first_name + "@tt.com" #TODO temp fix for development
    #@user.password = @user.last_name #TODO temp fix for development
    @user.password = SecureRandom.base64(16).gsub(/=+$/, '')
    @user.customer_id = Customer.find(params[:customer_id]).id
    #@user.customer_id = params[:customer_id]
    if @user.save
        flash[:notice] = "User account successfully created"
        render action: "show"
    else
        logger.debug @user.errors.full_messages
        flash[:notice] = "User account creation did not go through"
        render action: "new"
    end
  end

  def destroy
    @user = User.find(params[:id]);
    if @user.destroy
        flash[:notice] = "User account deleted"
        redirect_to customer_path(@user.customer_id)
    else
        flash[:notice] = "User account deletion failed"
        redirect_to customer_path(@user.customer_id)
    end
  end
end
