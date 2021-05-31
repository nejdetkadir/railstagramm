class Users::RegistrationsController < Devise::RegistrationsController

  protected

    def after_update_path_for(resource)
      request.referer
    end
end