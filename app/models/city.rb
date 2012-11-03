class City
  include Mongoid::Document
  include Mongoid::Timestamps

  field :name
  field :channel
  field :timezone
  field :lat, type: Float
  field :lng, type: Float

  validates_uniqueness_of :name

  def latest_photos
    geo_ids = Rails.cache.fetch(name, :expires_in => 10.minutes) do
      response = Faraday.get "#{SUBS_HOST}/api/v1/entities/#{name.parameterize}"
      MultiJson.decode(response.body)
    end
    geo_ids.map do |geo_id|
      Photo.geo_recent(geo_id)
    end.flatten.uniq(&:id).map{|p| p.city_name = name; p}
  end
end
