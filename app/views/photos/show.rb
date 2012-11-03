module Photos
  class Show < ::Stache::View
    def src
      @insta.images.standard_resolution.url
    end
  end
end