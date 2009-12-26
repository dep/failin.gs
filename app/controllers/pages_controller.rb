class PagesController < ApplicationController
  def show
    return unless stale? :last_modified => last_modified
    render params[:permalink]
  end

  private

  def last_modified
    file = "#{Rails.root}/app/views/pages/#{params[:permalink]}.html.erb"
    File.mtime(file) if File.exist?(file)
  end
end
