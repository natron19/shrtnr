class Api::V1::UsersController < Api::BaseController
  include UsersHelper

  before_action :authenticate_with_api_key

  def show 
    @user = User.find_by_id(params[:id])
    if @user
      render json: @user.as_json(only: [:name, :email], include: {links: {only: [:short_url, :long_url, :clicks]}})
    end
  end 
end
