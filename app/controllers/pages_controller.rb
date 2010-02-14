class PagesController < ApplicationController
  # caches_page :root, :terms, :thankyou

  before_filter :require_no_user, only: %w(root)
  before_filter :validate_cache

  def root
    @email        = Email.new
    @user         = User.new
    @user_session = UserSession.new
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
