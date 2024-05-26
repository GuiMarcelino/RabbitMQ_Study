require 'bunny'

hostname = ENV['RABBITMQ_HOST'] || 'localhost'

connection = Bunny.new(hostname: hostname)
connection.start

channel = connection.create_channel
queue = channel.queue('chat_queue', durable: true)
exchange = channel.direct('chat_exchange')

queue.bind(exchange, routing_key: 'chat')

puts " [*] Waiting for messages in #{queue.name}. To exit press CTRL+C"

begin
  queue.subscribe(block: true) do |_delivery_info, _properties, body|
    message = JSON.parse(body)
    MessagesController.store_message(message)
    puts " [x] Received #{message}"
  end
rescue Interrupt => _
  connection.close
  exit(0)
end
