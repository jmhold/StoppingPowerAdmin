CarrierWave.configure do |config|
  key = ENV['S3_KEY']
  secret = ENV['S3_SECRET']
  if Rails.env.development?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => key,
      :aws_secret_access_key  => secret,
      :region                 => 'us-west-2',
    }
    config.fog_directory  = 'brado-sp-dev'                     # required
    # config.fog_public     = false                                   # optional, defaults to true
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  elsif Rails.env.production?
    config.fog_credentials = {
      :provider               => 'AWS',
      :aws_access_key_id      => key,
      :aws_secret_access_key  => secret,
      :region                 => 'us-west-2',
    }
    config.fog_directory  = 'brado-sp'                     # required
    # config.fog_public     = false                                   # optional, defaults to true
    # config.fog_attributes = {'Cache-Control'=>'max-age=315576000'}  # optional, defaults to {}
  else
    config.storage = :file
  end
end