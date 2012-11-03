class CitiesController < ApplicationController
  skip_before_filter :authenticate_user!

  def index
  end

  def show
    @city = City.find(params[:id])
    @photos = @city.latest_photos.sort_by(&:created_time)
  end
end
