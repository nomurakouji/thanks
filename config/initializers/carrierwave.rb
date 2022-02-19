CarrierWave.configure do |config|
    require 'carrierwave/storage/abstract'
    require 'carrierwave/storage/file'
    require 'carrierwave/storage/fog'
  
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     'AKIA2A3RAKUL3MFEL7O5',
        aws_secret_access_key: '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',
        region:                'ap-northeast-1',
        path_style:            true,
    }
  
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
  
    case Rails.env
      when 'production'
        config.fog_directory = 'green-production'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/green-production'
      when 'development'
        config.fog_directory = 'green-development'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/green-development'
    end
  end