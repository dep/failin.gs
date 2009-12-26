class EmailsController < ApplicationController
  respond_to :html
  respond_to :js, :only => :create

  def new
    respond_with(@email = Email.new)
  end

  def create
    respond_with(@email = Email.create(params[:email]), location: root_path)
  end
end
