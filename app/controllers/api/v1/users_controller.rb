class Api::V1::UsersController < Api::ApiController

  def index
    @users = User.all
    render json: construct_json(200, {names: @users.map(&:full_name)})
  end

  def show
    @user = User.find(params[:id])
    render json: construct_json(200, {name: @user.full_name})
  end
end