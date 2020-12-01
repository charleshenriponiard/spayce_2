class MessagesController < ApplicationController
  def new
    @message = Message.new
  end

  def create
    @message = Message.new(message_params)
    if @message.valid?
      MessageMailer.contact_me(@message, current_user).deliver_now
      redirect_to root_path, notice: "Nous avons bien reçu votre message, merci !"
    else
      render :new
    end
  end

  protected

  def message_params
    params.require(:message).permit(:subject, :body)
  end
end
