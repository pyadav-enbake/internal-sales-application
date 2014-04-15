class SettingsController < ApplicationController
  before_filter :check_auth, :authenticate

  def show
    @setting = AdminSetting.find_by(name: 'coversheet_percentage')
  end

  def update
    @setting = AdminSetting.find_by(name: 'coversheet_percentage')
    coversheet_percentage = params[:coversheet_percentage].to_f
    if coversheet_percentage < 1 or coversheet_percentage > 100
      redirect_to settings_url, alert: 'Invalid coversheet percentage value'
    else
      @setting.update(value: coversheet_percentage)
      logger.info "coversheet_percentage updated to #{coversheet_percentage}"
      redirect_to settings_url, notice: 'Settings updated succesfully.'
    end
  end

end
