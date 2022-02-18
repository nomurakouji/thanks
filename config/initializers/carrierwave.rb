CarrierWave.configure do |config|
    require 'carrierwave/storage/abstract'
    require 'carrierwave/storage/file'
    require 'carrierwave/storage/fog'
  
    config.storage :fog
    config.fog_provider = 'fog/aws'
    config.fog_credentials = {
        provider:              'AWS',
        aws_access_key_id:     'AKIA2A3RAKUL57LQWAJS',
        aws_secret_access_key: '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',
        region:                'ap-northeast-1',
        path_style:            true,
    }
  
    config.fog_public     = true
    config.fog_attributes = {'Cache-Control' => 'public, max-age=86400'}
  
    case Rails.env
      when 'production'
        config.fog_directory = 'thanks-production'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/thanks-production'
      when 'development'
        config.fog_directory = 'achieve-development'
        config.asset_host = 'https://s3-ap-northeast-1.amazonaws.com/achieve-development'
    end
  end