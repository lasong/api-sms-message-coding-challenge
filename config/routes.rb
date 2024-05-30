Rails.application.routes.draw do
  scope '/api' do
    resources :messages, only: [] do
      collection do
        post 'send_sms'
      end
    end
  end
end
