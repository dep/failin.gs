class FailingsController < ApplicationController
  respond_to :html, except: %w(knew no_idea disagree)
  respond_to :js

  before_filter :require_user, only: %w(knew no_idea disagree)

  def index
    if request.format.js?
      if request.env["HTTP_REFERER"].blank?
        logger.info "Could not detect where embedded location"
      else
        logger.info "Embedded in #{request.env["HTTP_REFERER"]}"
      end

      return unless stale? etag: form_authenticity_token,
        last_modified: App.launched_at, public: true
    end

    load_profile_user

    # if App.optimized?
      etag = [
        @user, @user == current_user, knows?(@user), form_authenticity_token
      ]
      return unless stale? etag: etag, last_modified: @user.updated_at,
        public: !logged_in? && known.empty?
    # end

    @failing = @user.failings.build
    @knows_user = knows_user?
  end

  def create
    load_profile_user

    @failing = @user.failings.new params[:failing]
    @failing.submitter = current_user
    @failing.submitter_ip = request.remote_ip
    @failing.token_id = @identity

    if knows? @user
      knows! @user
      @failing.answer = @user.answer
    end

    if @failing.save
      if @user.subscribe? && @user != current_user
        Resque.enqueue MailJob, @failing.class.name, @failing.id
      end

      redirect_to profile_path(@user), notice: "Thanks for your feedback!"
    else
      render "index"
    end
  end

  def show
    load_failing

    etag = [
      @failing, @user == current_user, knows?(@user), form_authenticity_token
    ]
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
    @user = current_user
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.knew!
    render "state_transition"
  rescue AASM::InvalidTransition
    head :unprocessable_entity
  end

  def no_idea
    @user = current_user
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.no_idea!
    render "state_transition"
  rescue AASM::InvalidTransition
    head :unprocessable_entity
  end

  def disagree
    @user = current_user
    @failing = current_user.failings.find(params[:id])
    @state_was = @failing.state
    @failing.disagree!
    render "state_transition"
  rescue AASM::InvalidTransition
    head :unprocessable_entity
  end

  private

  def knows_user?
    return false unless @user

    @user == current_user ||
      (session[:knows] && session[:knows].include?(@user.id))
  end
end
