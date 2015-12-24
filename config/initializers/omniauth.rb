Rails.application.config.middleware.use OmniAuth::Builder do
  provider :uber, ENV['CLIENT_ID'], ENV['CLIENT_SECRET']
end