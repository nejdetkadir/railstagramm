module FriendshipHelper
  
  # status:
  # 0 -> not association
  # 1 -> follow requested
  # 2 -> friends
  # 3 -> block

  def send_follow_request(friend_id)
    if check_follow_request(friend_id)
      Friendship.create(user_id: current_user.id, friend_id: friend_id, status: 1)
    end
  end

  def delete_follow_request(friend_id)
    friendship = Friendship.where(user_id: friend_id, friend_id: current_user.id, status: 1).first

    if friendship
      friendship.destroy
    end
  end

  def check_follow_request(friend_id)
    if !current_user.eql?(User.find(friend_id))
      !Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 1).first
    else
      return false
    end
  end

  def friends_with?(friend_id)
    unless Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 2).first
      return false
    end 

    return true
  end

  def block_with?(friend_id)
    unless Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 3).first
      return false
    end

    return true
  end

  def block_friend(friend_id)
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend_id).first

    unless friendship
      Friendship.create(user_id: current_user.id, friend_id: friend_id, status: 3)
    end
  end

  def unblock_friend(friend_id)
    friendship = Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 3).first

    if friendship
      Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 3).first.destroy
    end
  end

  def remove_friend(friend_id)
    if friends_with?(User.find(friend_id))
      Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 2).first.destroy
    end
  end

  def check_pending(friend_id)
    unless Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 1).first
      return false
    end

    return true
  end

  def remove_pending_request(friend_id)
    if check_pending(friend_id)
      Friendship.where(user_id: current_user.id, friend_id: friend_id, status: 1).first.destroy
    end
  end

  def accept_follow_request(friend_id)
    friendship = Friendship.where(user_id: friend_id, friend_id: current_user.id, status: 1).first
    friendship.status = 2
    friendship.save
  end
end