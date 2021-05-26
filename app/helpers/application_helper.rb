module ApplicationHelper
  def resource_name
    :user
  end

  def resource
    @resource ||= User.new
  end

  def resource_class
    User
  end

  def devise_mapping
    @devise_mapping ||= Devise.mappings[:user]
  end

  def check_me(user)
    if user_signed_in?
      current_user.eql?(user)
    else
      false
    end
  end
end
