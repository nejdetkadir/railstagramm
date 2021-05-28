class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments, dependent: :destroy
  has_many :post_likes, dependent: :destroy

  mount_uploader :image, PostUploader

  validates_presence_of :image, message: "can not be blank"
end
