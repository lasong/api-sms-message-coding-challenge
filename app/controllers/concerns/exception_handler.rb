module ExceptionHandler
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordInvalid, with: :unprocessable_entity

    rescue_from StandardError do |error|
      render json: { error: error.message }, status: :internal_server_error
    end
  end

  private

  def unprocessable_entity(error)
    render json: { error: error.message }, status: :unprocessable_entity
  end
end
