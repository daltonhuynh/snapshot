INSTAGRAM_CONFIG = YAML.load_file("#{Rails.root}/config/instagram.yml")[Rails.env]
Instagram.configure do |config|
  config.client_id = INSTAGRAM_CONFIG['id']
  config.client_secret = INSTAGRAM_CONFIG['secret']
end