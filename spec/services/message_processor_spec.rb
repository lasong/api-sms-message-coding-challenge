require 'rails_helper'

RSpec.describe MessageProcessor, type: :service do
  let(:sms_response) { double('sms_response', success?: true) }
  let(:sms_message) { 'These are message parts for sms sending' }
  let(:message_parts) { ['These are', 'message parts', 'for sms sending'] }

  describe '.process' do
    before do
      allow_any_instance_of(MessageSplitter).to receive(:split_message).and_return(message_parts)
    end

    it 'sends sms messages' do
      allow(Message).to receive(:create!)

      expect(SmsSender).to receive(:send).with(message_parts).and_return(sms_response)

      described_class.new(sms_message).process
    end

    it 'creates messages records if sms sending was successful' do
      allow(SmsSender).to receive(:send).and_return(sms_response)

      expect { described_class.new(sms_message).process }.to change(Message, :count).by(3)
    end

    context 'sms sending not successful' do
      let(:sms_error_response) { double('sms_error_response', success?: false) }
      before { allow(SmsSender).to receive(:send).and_return(sms_error_response) }

      it 'raises SmsSendError' do
        expect do
          described_class.new(sms_message).process
        end.to raise_error(ExceptionHandler::SmsSendError)
      end

      it 'does not create Message records' do
        expect do
          described_class.new(sms_message).process
        end.to raise_error(ExceptionHandler::SmsSendError)

        expect(Message.count).to eq 0
      end
    end
  end
end
