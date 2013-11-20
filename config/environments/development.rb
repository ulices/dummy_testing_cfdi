DummyTestingCfdi::Application.configure do
  # Settings specified here will take precedence over those in config/application.rb.

  # In the development environment your application's code is reloaded on
  # every request. This slows down response time but is perfect for development
  # since you don't have to restart the web server when you make code changes.
  config.cache_classes = false

  # Do not eager load code on boot.
  config.eager_load = false

  # Show full error reports and disable caching.
  config.consider_all_requests_local       = true
  config.action_controller.perform_caching = false

  # Don't care if the mailer can't send.
  config.action_mailer.raise_delivery_errors = false

  # Print deprecation notices to the Rails logger.
  config.active_support.deprecation = :log

  # Raise an error on page load if there are pending migrations
  config.active_record.migration_error = :page_load

  # Debug mode disables concatenation and preprocessing of assets.
  # This option may cause significant delays in view rendering with a large
  # number of complex assets.
  config.assets.debug = true

  # FacturacionModerna user keys
  config.fm_id =                   'UsuarioPruebasWS'
  config.fm_password =             'b9ec2afa3361a59af4b4d102d3f704eabdf097d4'
  config.fm_namespace =            'https://t2demo.facturacionmoderna.com/timbrado/soap'
  config.fm_endpoint =             'https://t2demo.facturacionmoderna.com/timbrado/soap'
  config.fm_wsdl =                 'https://t2demo.facturacionmoderna.com/timbrado/wsdl'
  config.fm_log =                  false
  config.fm_ssl_verify_mode =      :none
end
