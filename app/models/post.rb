class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy
  has_many :saved_posts, dependent: :destroy

  mount_uploader :image, PostUploader

  validates_presence_of :image, message: "can not be blank"

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user } 
end
