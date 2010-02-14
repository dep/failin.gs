class FailingsController < ApplicationController
  respond_to :html, except: %w(knew no_idea disagree)
  respond_to :js

  before_filter :require_user, only: %w(knew no_idea disagree)

  def index
    if request.format.js?
      return unless stale? etag: form_authenticity_token,
        last_modified: App.launched_at
    end

    load_profile_user

    if App.optimized?
      etag = [@user, @user == current_user, form_authenticity_token]
      return unless stale? etag: etag, last_modified: @user.updated_at,
        public: !logged_in?
    end

    @failing = @user.failings.build
  end

  def create
    load_profile_user

    @failing = @user.failings.new params[:failing]
    @failing.submitter = current_user
    @failing.submitter_ip = request.remote_ip
    @failing.token_id = @identity

    if @failing.save
      if @user.subscribe? && @user != current_user
        Delayed::Job.enqueue MailJob.new(@failing)
      end

      redirect_to profile_path(@user), notice: "Thanks for your feedback!"
    else
      render "index"
    end
  end

  def show
    load_failing

    etag = [@failing, @user == current_user, form_authenticity_token]
    return unless stale? etag: etag, last_modified: @failing.updated_at,
      public: !logged_in?

    if @user.private?
      if logged_in?
        redirect_to profile_path(@user) if @user != current_user
      else
        store_location
        require_user
      end
    end
  end

  def knew
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.knew!
    render "state_transition"
  rescue ActiveModel::StateMachine::InvalidTransition
    head :unprocessable_entity
  end

  def no_idea
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.no_idea!
    render "state_transition"
  rescue ActiveModel::StateMachine::InvalidTransition
    head :unprocessable_entity
  end

  def disagree
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.disagree!
    render "state_transition"
  rescue ActiveModel::StateMachine::InvalidTransition
    head :unprocessable_entity
  end
end
