if Rails.env.production?
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => ENV['S3_ACCESS_KEY_ID'],
        :aws_secret_access_key  => ENV['S3_SECRET_ACCESS_KEY']
        # :region                 => ENV['S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
    }
    config.fog_directory  = ENV['S3_FOG_DIRECTORY']
  end
else
  CarrierWave.configure do |config|
    config.fog_credentials = {
        :provider               => 'AWS',
        :aws_access_key_id      => 'S3_ACCESS_KEY_ID',
        :aws_secret_access_key  => 'S3_SECRET_ACCESS_KEY'
        # :region                 => ENV['S3_REGION'] # Change this for different AWS region. Default is 'us-east-1'
    }
    config.fog_directory  = 'S3_FOG_DIRECTORY'
  end
end
