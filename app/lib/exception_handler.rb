module ExceptionHandler
  extend ActiveSupport::Concern

  class SmsSendError < StandardError; end

  included do
    rescue_from ActiveRecord::RecordInvalid, ExceptionHandler::SmsSendError do |error|
      json_response({ message: error.message }, :unprocessable_entity)
    end
  end
end
