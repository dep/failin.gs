class ExceptionNotifier
  def initialize(app, options = {})
    @app, @options = app, options
  end

  def call(env)
    @app.call(env)
  rescue Exception => exception
    MailJob.perform_exception(exception, env) unless [
      AbstractController::ActionNotFound,
      # ActionController::InvalidAuthenticityToken,
      ActionController::RoutingError,
      ActiveRecord::RecordNotFound,
      URI::InvalidURIError
    ].include?(exception.class)

    raise exception
  end
end
