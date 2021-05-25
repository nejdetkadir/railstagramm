class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception, prepend: true

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user
    redirect_to admin_feed_path if signed_in?
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :username, :birthday])
    end

    def after_sign_in_path_for(resource)
      admin_feed_path
    end
end