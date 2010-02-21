class PreferencesController < ApplicationController
  before_filter :require_user

  VALID_KEYS = %w(avatar_service hide_public_notice)

  def create
    return head :unprocessable_entity unless VALID_KEYS.include? params[:key]
    value = case params[:value]
      when "true"  then true
      when "false" then false
      when "nil"   then nil
      else params[:value]
    end
    current_user.preferences[params[:key]] = value
    current_user.save!

    render :update do |page|
      case params[:key]
      when "hide_public_notice"
        page[:public_notice].visual_effect :fade
      when "avatar_service"
        page.select(".pic_area img").first.replace avatar_for(current_user, size: 200)
      end
    end
  end
end
