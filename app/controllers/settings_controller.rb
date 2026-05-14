# frozen_string_literal: true

class SettingsController < ApplicationController
  before_action :require_admin, only: [ :update ]
  def show
    @user = Current.user
  end

  def update
    Setting.instance.update!(setting_params)

    redirect_to setting_path, notice: t("notice.updated")
  end

  private

  def setting_params
    params.require(:setting).permit(Setting::AVAILABLE_SETTINGS)
  end
end
