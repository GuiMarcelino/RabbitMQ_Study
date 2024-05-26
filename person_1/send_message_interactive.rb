require 'bunny'
require 'json'
require 'thread'

def start_interactive_messaging(app_name, receiver)
  hostname = ENV['RABBITMQ_HOST'] || 'localhost'

  connection = Bunny.new(hostname: hostname)
  connection.start

  channel = connection.create_channel
  exchange = channel.direct('chat_exchange')
  queue = channel.queue("#{app_name}_queue", durable: true)
  queue.bind(exchange, routing_key: app_name)  # Certifique-se de que o roteamento está correto

  # Thread para receber mensagens
  Thread.new do
    queue.subscribe(block: true) do |_delivery_info, _properties, body|
      message = JSON.parse(body)
      puts "\n[#{message['sender']}]: #{message['content']}"
      print "> "
    end
  end

  puts "Interactive messaging started for #{app_name}. Type your message and press Enter to send. Type 'exit' to quit."

  loop do
    print "> "
    content = STDIN.gets.chomp
    break if content == 'exit'

    message = { content: content, sender: app_name, receiver: receiver }
    exchange.publish(message.to_json, routing_key: receiver)  # Use o receptor como chave de roteamento
    puts "Message sent: #{message.to_json}"
  end

  connection.close
end

if ARGV.length != 2
  puts "Usage: ruby send_message_interactive.rb <app_name> <receiver>"
  exit(1)
end

app_name = ARGV[0]
receiver = ARGV[1]

start_interactive_messaging(app_name, receiver)
