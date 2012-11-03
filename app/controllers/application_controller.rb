class ApplicationController < ActionController::Base
  protect_from_forgery

  before_filter :authenticate_user!
  before_filter :set_user

  private

    # Hack for getting current_user to work in views for application layout
    def set_user
      @user = current_user
    end
end
