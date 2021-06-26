Rails.application.routes.draw do
  namespace :api, format: :json do
    namespace :v1 do
      use_doorkeeper do
        skip_controllers :authorizations, :applications, :authorized_applications

        controllers tokens: 'sessions'
      end
    end
  end
end
