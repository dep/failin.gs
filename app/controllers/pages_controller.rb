class PagesController < ApplicationController
  before_filter :require_no_user, only: %w(root)
  before_filter :require_user, only: %w(welcome)

  def root
    @email        = Email.new
    @user         = User.new
    @user_session = UserSession.new
  end

  private

  def last_modified
    file = "#{Rails.root}/app/views/pages/#{params[:permalink]}.html.erb"
    File.mtime(file) if File.exist?(file)
  end
end
