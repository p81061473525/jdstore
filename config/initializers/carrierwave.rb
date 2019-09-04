CarrierWave.configure do |config|
  # if Rails.env.production?
    config.fog_credentials = {
      provider:              'AWS',                        # required
      aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],     # required unless using use_iam_profile
      aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"], # required unless using use_iam_profile
      # use_iam_profile:       true,                         # optional, defaults to false
      region:                ENV["AWS_REGION"],            # optional, defaults to 'us-east-1'
      # path_style: true,
      # endpoint:              'https://s3.example.com:8080' # optional, defaults to nil
    }
    config.fog_directory = ENV["AWS_BUCKET_NAME"]                                     # required
    # config.fog_public     = false                                                 # optional, defaults to true
    # config.fog_attributes = { cache_control: "public, max-age=#{365.days.to_i}" } # optional, defaults to {}
    # else
      config.storage :fog
    # end
end



  # if Rails.env.production?
  #   config.fog_provider = 'fog'
  #   config.fog_credentials = {
  #     provider:              'AWS',
  #     aws_access_key_id:     ENV["AWS_ACCESS_KEY_ID"],
  #
  #     aws_secret_access_key: ENV["AWS_SECRET_ACCESS_KEY"],
  #
  #     region:                ENV["AWS_REGION"]
  #
  #   }
  #   config.fog_directory  = ENV["AWS_BUCKET_NAME"]
  #
  #
  # else
  #   config.storage :file
  # end
# end
