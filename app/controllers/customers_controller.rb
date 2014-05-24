class CustomersController < ApplicationController
  before_filter :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

  def update
    @customer = current_customer
    #if @customer.update_attributes(params[:customer])
    if @customer.update_attributes!(update_params)
      # handle a successful update
      flash[:success] = "Profile updated"
      redirect_to @customer
    else
      # print the errors to the development log
      Rails.logger.info(@customer.errors.messages.inspect)
      flash[:error] = "Something wrong? Profile NOT updated"
      render 'edit'
    end
  end

  private
    def update_params
      params[:customer].slice(:first_name, :last_name)
    end
end
