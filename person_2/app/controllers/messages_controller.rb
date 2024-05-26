class MessagesController < ApplicationController
  def create
    message = Message.new(message_params)
    if message.valid?
      exchange = Rails.application.config.rabbitmq[:exchange]
      exchange.publish(message.to_json, routing_key: 'chat')
      render json: { status: 'Message sent' }, status: :created
    else
      render json: { errors: message.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def index
    @messages = [] # Aqui você adicionaria a lógica para receber mensagens
    render json: @messages
  end

  private

  def message_params
    params.require(:message).permit(:content, :sender, :receiver)
  end
end
