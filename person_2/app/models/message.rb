class Message
  include ActiveModel::Model
  attr_accessor :content, :sender, :receiver
end
