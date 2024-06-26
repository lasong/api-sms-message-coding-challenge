require 'securerandom'

class MessageProcessor
  def initialize(message)
    @message = message
  end

  def process
    message_parts = MessageSplitter.new(message).split_message

    SmsSender.send(message_parts)

    message_uuid = SecureRandom.uuid
    message_parts.each_with_index do |part, index|
      Message.create!(content: part, part_number: index + 1, uuid: message_uuid)
    end
  end

  private

  attr_reader :message
end
