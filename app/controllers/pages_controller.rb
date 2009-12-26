class PagesController < ApplicationController
  before_filter :validate_cache

  def root
    @user, @user_session = User.new, UserSession.new
  end

  private

  def validate_cache
    return unless stale? :last_modified => last_modified
  end

  def last_modified
    file = "#{Rails.root}/app/views/pages/#{params[:permalink]}.html.erb"
    File.mtime(file) if File.exist?(file)
  end
end
