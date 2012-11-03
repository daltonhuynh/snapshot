module Users
  class Likes < ::Stache::View

    def init
      @photos.to_json.html_safe
    end

  end
end