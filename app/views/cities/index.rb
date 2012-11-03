module Cities
  class Index < ::Stache::View
    include ::Shared::Channels

    def init
      photos = City.all.map(&:latest_photos).flatten.sort_by(&:created_time).first(15)
      json = {
        photos: photos,
        faye: YAML.load_file("#{Rails.root}/config/faye.yml")[Rails.env],
        channels: channels(["/instagram/*"])
      }
      json.merge!(cities: City.all.map(&:attributes).map{|c| c.select{|k, _| ["name", "lat", "lng"].include?(k)}.merge(url: city_path(c["_id"]))}) if user_signed_in?
      json.to_json.html_safe
    end

    def sign_up_path
      omniauth_authorize_path(User, "facebook")
    end

  end
end