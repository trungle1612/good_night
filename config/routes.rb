Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications

        controllers tokens: 'sessions'
      end

      resources :followers, only: [:create, :destroy], param: :user_id
      resources :time_sleeps, only: [:create, :index]
    end
  end
end
