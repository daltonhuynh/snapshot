class UsersController < ApplicationController
  skip_before_filter :authenticate_user!, :only => [:show]

  def show
    @user = User.find(params[:id])
    @auth = @user.auth(:facebook)
  end

  def likes
    @photos = Photo.data_liked_by(current_user)
  end
end