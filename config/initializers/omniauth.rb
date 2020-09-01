Rails.application.config.middleware.use OmniAuth::Builder do
  provider :yahoojp, ENV['YAHOO_CLIENT_ID'], ENV['YAHOO_CLIENT_SECRET'], 
  {
          :scope => 'openid profile email',
          :provider_ignores_state => true
  }
end