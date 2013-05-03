CarrierWave.configure do |config|
  config.fog_credentials = {
    :provider               => 'AWS',                        # required
    :aws_access_key_id      => "AKIAJHPQ4WTC2VBM4ZBA",                        # required
    :aws_secret_access_key  => "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"                        # required
  }
  config.fog_directory  = 'nine.hundred.hours.dev'                     # required
  config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
end



