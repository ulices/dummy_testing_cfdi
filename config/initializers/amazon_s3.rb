CarrierWave.configure do |config|
  config.fog_credentials = {
    provider:              'AWS',
    aws_access_key_id:     'AKIAIARBQCHD5CHXAOEA',
    aws_secret_access_key: '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',
    region:                'us-east-1'
  }
  config.fog_directory  = 'nuki-dev'
  config.fog_public     = false
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}
end
