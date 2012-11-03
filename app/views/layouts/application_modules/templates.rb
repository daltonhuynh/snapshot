module Layouts
  module ApplicationModules
    module Templates

      def templates
        templates = [
          "shared/image",
          "shared/notifications",
          "shared/sell_image"
        ]
        template_include_tag *templates
      end

    end
  end
end