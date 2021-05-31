class Friendship < ApplicationRecord
  belongs_to :user
  belongs_to :friend, class_name: 'User'

  validates_presence_of :user_id, :friend_id
  validate :user_is_not_equal_friend
  validates_uniqueness_of :user_id, scope: [:friend_id]

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user } 

  def is_mutual
    self.friend.friends.include?(self.user)
  end

  private
    def user_is_not_equal_friend
      errors.add(:friend, "can not be the same as the user") if self.user == self.friend
    end
end
