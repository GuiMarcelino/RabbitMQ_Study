require 'bunny'

hostname = ENV['RABBITMQ_HOST'] || 'localhost'

connection = Bunny.new(hostname: hostname)
connection.start

channel = connection.create_channel
exchange = channel.direct('chat_exchange')

Rails.application.config.rabbitmq = {
  connection: connection,
  channel: channel,
  exchange: exchange
}
