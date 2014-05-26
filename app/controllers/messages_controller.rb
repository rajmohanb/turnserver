class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      ContactusMailer.new_message(@message).deliver
      redirect_to root_url, notice: "Thank you for contacting us. We will get in touch with you shortly"
    else
      flash.now.alert = "Please fill all the fields."
      render "new"
    end
  end
end
