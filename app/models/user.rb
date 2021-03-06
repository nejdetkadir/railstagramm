class User < ApplicationRecord

  extend FriendlyId
  friendly_id :username, use: :slugged

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :omniauthable, omniauth_providers: [:google_oauth2, :github]

  validates_presence_of [:fullname, :birthday, :username]
  validates_uniqueness_of :username

  mount_uploader :profile, ProfileUploader

  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :saved_posts, dependent: :destroy
  has_many :rooms
  has_many :participants

  has_many :friendships, dependent: :destroy
  has_many :friends, through: :friendships

  belongs_to :gender

  def should_generate_new_friendly_id?
    username_changed?
  end

  def self.from_omniauth(access_token)
    # You can learn which provider used
    # provider = access_token.provider 

    data = access_token.info

    user = User.where(email: data['email']).first

    unless user
      user = User.create(email: data['email'],password: Devise.friendly_token[0,20])
    end
    user
  end

  def followers 
    Friendship.where(friend_id: self.id, status: 2)
  end

  def following
    self.friendships.where(status: 2)
  end

  def follow_requests
    Friendship.where(friend_id: self.id, status: 1)
  end
end
