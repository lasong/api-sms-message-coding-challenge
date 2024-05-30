require 'rails_helper'

RSpec.describe 'Messages API', type: :request do
  describe 'POST /api/messages/send_sms' do
    let(:path) { '/api/messages/send_sms' }
    let(:short_content) { 'This is a short sms message.' }
    let(:long_content) do
      'This is a very long message that needs to be split into multiple parts with a suffix ' \
      'because it exceeds the maximum length of an SMS message, which is 160 characters.'
    end
    let(:params) do
      { message: { content: short_content } }
    end

    it 'returns success response' do
      post path, params: params

      expect(response).to have_http_status(201)
    end

    it 'sends 1 sms message if content is less than 160 characters' do
      expect(SmsSender).to receive(:send).with([short_content]).and_call_original

      post path, params: params
    end

    it 'sends multiple messages if content is more than 160 characters' do
      params[:message][:content] = long_content

      message_parts = [
        'This is a very long message that needs to be split into multiple parts with a ' \
        'suffix because it exceeds the maximum length of an SMS message, which is - part 1',
        '160 characters. - part 2'
      ]

      expect(SmsSender).to receive(:send).with(message_parts).and_call_original

      post path, params: params
    end

    it 'saves the message content' do
      expect { post path, params: params }.to change(Message, :count).by(1)
    end
  end
end
