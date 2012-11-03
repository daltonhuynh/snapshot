module Layouts
  module ApplicationModules
    module NavBar

      def logo
        link_to "Snapshot", root_url, :class => "brand"
      end

      def right_nav
        if user_signed_in?
          {
            links: [
              {element: link_to("Activity", photos_path)},
              {element: "<a href='#{likes_user_path(@user)}'><i class='icon-heart icon-white'></i></a>"}
            ],
            dropdown: {
              profile_pic: @user.auth(:facebook).profile_picture,
              name: @user.auth(:facebook).first_name,
              links: [
                {element: link_to("Settings", @user)},
                {element: link_to("Logout", destroy_user_session_path, :method => :delete)}
              ]
            }
          }
        else
          {
            links: [
              {element: link_to("Login with Facebook", omniauth_authorize_path(User, "facebook"))},
            ]
          }
        end
      end

    end
  end
end