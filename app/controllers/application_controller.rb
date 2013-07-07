class ApplicationController < ActionController::Base
  protect_from_forgery

  def after_sign_in_path_for(resource)
    sign_in_url = url_for(:action => 'new', :controller => 'sessions', :only_path => false, :protocol => 'http')
    logger.fatal "This is the sign in url: #{sign_in_url}"
    if request.referer == sign_in_url
      logger.fatal "Yeah! this is sign in url"
      current_customer
      # super
    else
      logger.fatal "This is the user path: #{current_user} : #{user_url(current_user)}"
      logger.fatal "This is the stored resource path: #{stored_location_for(resource)}"
      logger.fatal "This is the referrer path: #{request.referrer}"
      customer_url(resource) || stored_location_for(resource) || request.referer
    end
  end
  
  # This is basically to identify/debug who has triggered a redirect_to
  def redirect_to(options = {}, response_status = {})
    ::Rails.logger.error("Redirected by #{caller(1).first rescue "unknown"}")
    super(options, response_status)
  end

end
