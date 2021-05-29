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

  def liked_post(post)
    post.post_likes.where(user_id: current_user.id, post_id: post.id).first
  end

  def saved_post(post)
    post.saved_posts.where(user_id: current_user.id, post_id: post.id).first
  end
end
