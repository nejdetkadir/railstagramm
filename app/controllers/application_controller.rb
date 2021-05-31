class ApplicationController < ActionController::Base

  include PublicActivity::StoreController 

  protect_from_forgery with: :exception, prepend: true
  layout :layout_by_resource

  before_action :configure_permitted_parameters, if: :devise_controller?

  def check_user
    redirect_to admin_feed_path if signed_in?
  end

  protected
    def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up, keys: [:fullname, :username, :birthday])
      devise_parameter_sanitizer.permit(:account_update, keys: [:fullname, :username, :bio, :gender_id, :public]) 
    end

    def after_sign_in_path_for(resource)
      admin_feed_path
    end

  private
    def layout_by_resource
      if devise_controller? && resource_name == :user && action_name == "edit" || action_name == "update"
        "admin"
      else
        "application"
      end
    end
end