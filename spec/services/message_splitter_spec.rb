require 'rails_helper'

RSpec.describe MessageSplitter, type: :service do
  it 'returns message in array if number of characters are less than 160' do
    message = 'This is not a very long message'
    service = described_class.new(message)

    message_parts = service.split_message

    expect(message_parts.length).to eq 1
    expect(message_parts[0]).to eq message
  end

  it 'splits long messages into parts without breaking words' do
    message = 'This is a very long message that needs to be split into multiple ' \
              'parts with a suffix because it exceeds the maximum length of an SMS ' \
              'message, which is 160 characters.'
    service = described_class.new(message)
    message_parts = service.split_message

    expect(message_parts.length).to be > 1
    message_parts.each do |part|
      expect(part.length).to be <= 160
      expect(part).to match(/ - part \d+$/)
    end
  end
end
