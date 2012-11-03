class Photo
  include Mongoid::Document
  include Mongoid::Timestamps
  include Mongo::Voteable

  field :instagram_id

  index :instagram_id, :unique => true

  voteable self, :up => +1, :down => -1

  def self.geo_recent(id)
    Rails.cache.fetch("geo_recent_#{id}", :expires_in => 1.minute) do
      Instagram.geography_recent_media(id)
    end
  end

  def self.data_liked_by(user)
    photos = up_voted_by(user).map(&:to_data).compact
    data_with_likes(photos, user)
  end

  def self.data_with_likes(data, user)
    data.map do |data|
      if photo = Photo.where(:instagram_id => data.id).first
        data.snap_like = true if user.vote_value(photo) == :up
      end
      data
    end
  end

  def self.data_liked
    liked_photos = all.reject{|p| p.votes_point == 0}
    liked_photos.map do |photo|
      data = photo.to_data
      data.voters = photo.up_voters(User).map(&:full_name).join(", ") if data
      data
    end.compact
  end

  def self.data_for(instagram_id)
    Rails.cache.fetch("photo_#{instagram_id}", :expires_in => 1.hour) do
      Instagram.media_item(instagram_id) rescue nil
    end
  end

  def to_data
    self.class.data_for(instagram_id)
  end

end
