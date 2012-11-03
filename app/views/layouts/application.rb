module Layouts
  class Application < ::Stache::View
    include ApplicationModules::NavBar
    include ApplicationModules::Templates

    def stylesheets
      stylesheet_link_tag "application", :media => "all"
    end

    def javascripts
      javascript_include_tag "application"
    end

    def controller
      params[:controller]
    end

    def action
      params[:action]
    end

    def alerts
      [:error, :warning, :info, :success].map do |type|
        next unless flash[type]
        {type: type.to_s, message: flash[type]}
      end.compact
    end

    def year
      Time.now.year
    end

  end
end