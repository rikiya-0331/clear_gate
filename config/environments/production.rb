require "active_support/core_ext/integer/time"

Rails.application.configure do
  config.enable_reloading = false
  config.eager_load = true
  config.consider_all_requests_local = false
  config.action_controller.perform_caching = true
  config.assets.compile = false
  config.assets.digest = true # この行を追加
  config.public_file_server.enabled = true
  config.active_storage.service = :local
  config.force_ssl = true
  config.logger = ActiveSupport::Logger.new(STDOUT)
    .tap  { |logger| logger.formatter = ::Logger::Formatter.new }
    .then { |logger| ActiveSupport::TaggedLogging.new(logger) }
  config.log_tags = [ :request_id ]
  config.log_level = ENV.fetch("RAILS_LOG_LEVEL", "info")
  config.action_mailer.perform_caching = false
  if ENV['RAILS_ENV'] == 'production'
    config.action_mailer.default_url_options = { host: ENV['RENDER_EXTERNAL_HOSTNAME'], protocol: 'https' }
    Rails.application.routes.default_url_options = { host: ENV['RENDER_EXTERNAL_HOSTNAME'], protocol: 'https' }
  end
  config.action_mailer.smtp_settings = {
    address:              ENV.fetch('MAILGUN_SMTP_SERVER'),
    port:                 ENV.fetch('MAILGUN_SMTP_PORT').to_i,
    authentication:       :plain,
    user_name:            ENV.fetch('MAILGUN_SMTP_LOGIN'),
    password:             ENV.fetch('MAILGUN_SMTP_PASSWORD'),
    domain:               ENV.fetch('MAILGUN_DOMAIN'),
    enable_starttls_auto: true
  }
  config.i18n.fallbacks = true
  config.active_support.report_deprecations = false
  config.active_record.dump_schema_after_migration = false
end