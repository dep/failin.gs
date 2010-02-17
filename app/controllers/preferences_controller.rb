class PreferencesController < ApplicationController
  before_filter :require_user

  VALID_KEYS = %w(hide_public_notice)

  def create
    return head :unprocessable_entity unless VALID_KEYS.include? params[:key]
    current_user.preferences[params[:key]] = (params[:value] == "true")
    current_user.save!

    render :update do |page|
      page[:public_notice].visual_effect :fade
    end
  end
end
