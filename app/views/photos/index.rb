module Photos
  class Index < ::Stache::View

    def liked
      @photos.map do |photo|
        {
          usernames: photo.voters,
          link: photo.link,
          src: photo.images.thumbnail.url
        }
      end
    end

  end
end