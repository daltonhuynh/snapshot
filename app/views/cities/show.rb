module Cities
  class Show < ::Stache::View
    include ::Shared::Channels

    def init
      @photos = Photo.data_with_likes(@photos, current_user) if current_user
      {
        faye: YAML.load_file("#{Rails.root}/config/faye.yml")[Rails.env],
        photos: @photos,
        channels: channels([@city.channel]),
        city: @city.attributes.select{|k, _| ["name", "lat", "lng"].include?(k)}
      }.to_json.html_safe
    end

    def city_name
      @city.name
    end

    def current_time
      Time.now.in_time_zone(@city.timezone).strftime("%-m/%-d/%Y %-I:%M:%S %p")
    end

    def users
      @photos.map(&:user).uniq(&:id).first(16)
    end

  end
end