class PhotosController < ApplicationController

  def index
    @photos = Photo.data_liked.reverse
  end

  def show
  end

  def create
    @photo = Photo.find_or_create_by(:instagram_id => params[:id])
    if current_user.voted?(@photo) && current_user.vote_value(@photo) == :up
      current_user.unvote(@photo)
    else
      current_user.vote(@photo, :up)
    end
    render :nothing => true, :status => :ok
  end
end
