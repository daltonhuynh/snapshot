module Users
  class Show < ::Stache::View

    def full_name
      @user.full_name
    end

    def src
      @auth.profile_picture
    end

  end
end