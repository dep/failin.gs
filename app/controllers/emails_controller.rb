class EmailsController < ApplicationController
  respond_to :html, :js

  def new
    respond_with(@email = Email.new)
  end

  def create
    respond_with(@email = Email.create(params[:email]), location: root_path)
  end
end
