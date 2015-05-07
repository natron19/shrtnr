class SettingsController < ApplicationController
  include SessionsHelper

  before_action :authentication_required

  def index
    @settings = current_user
  end

  def update
    @settings = current_user
    if @settings.update_attributes(settings_params)
      redirect_to settings_url, notice: "Successfully updated settings"
    else
      redirect_to settings_url, alert: "Failed to update settings"
    end
  end

  def new_api_key
    current_user.generate_api_key
    if current_user.save 
      redirect_to settings_path, notice: "New key for you"
    else
      redirect_to settings_path, notice: "No key for you" 
    end 
  end 


  private

    def settings_params
      params.require(:settings).permit(:name, :email)
    end
end
