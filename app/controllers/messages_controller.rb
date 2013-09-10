class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(params[:message])
    if @message.valid?
      ContactusMailer.new_message(@message).deliver
      redirect_to root_url, notice: "Message sent! Thank you for contacting us."
    else
      flash.now.alert = "Please fill all the fields."
      render "new"
    end
  end
end
