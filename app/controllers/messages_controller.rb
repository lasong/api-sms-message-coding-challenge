class MessagesController < ApplicationController
  def send_sms
    MessageProcessor.new(message_params[:content]).process
    json_response({ message: 'SMS sent' }, :created)
  end

  private

  def message_params
    params.require(:message).permit(:content)
  end
end
