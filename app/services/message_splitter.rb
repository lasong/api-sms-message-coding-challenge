class MessageSplitter
  MAX_LENGTH = 160
  SUFFIX_PATTERN = ' - part %d'.freeze

  def initialize(message)
    @message = message
  end

  def split_message
    return [message] if message.length <= MAX_LENGTH

    message_parts(message.split)
  end

  private

  attr_reader :message

  def message_parts(words)
    parts = []
    last_message_part = words.reduce('') do |current_part, word|
      part_with_word = "#{current_part} #{word}".strip
      part_number = parts.size + 1

      next part_with_word if part_with_word.length + suffix(part_number).length <= 160

      parts << message_with_suffix(current_part, part_number)
      word
    end

    parts << message_with_suffix(last_message_part, parts.size + 1)
  end

  def suffix(part_number)
    SUFFIX_PATTERN % part_number
  end

  def message_with_suffix(message, part_number)
    "#{message}#{suffix(part_number)}"
  end
end
