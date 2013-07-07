class CustomersController < ApplicationController
  before_filter :authenticate_customer!

  def show
    @customer = current_customer
  end

  def edit
    @customer = current_customer
  end

end
