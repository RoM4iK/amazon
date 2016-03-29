Devise.setup do |config|
  config.mailer_sender = 'please-change-me-at-config-initializers-devise@example.com'
  require 'devise/orm/active_record'
  config.case_insensitive_keys = [:email]
  config.strip_whitespace_keys = [:email]
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 10
  config.reconfirmable = true
  config.expire_all_remember_me_on_sign_out = true
  config.password_length = 8..72
  config.reset_password_within = 6.hours
  config.scoped_views = true
  config.default_scope = :customer
  config.sign_out_via = :delete
  config.omniauth :facebook, ENV['APP_ID'], ENV['APP_SECRET'], scope: 'email', info_fields: 'email,first_name,last_name'
end
