class Post < ApplicationRecord
  belongs_to :user
  has_many :post_comments

  mount_uploader :image, PostUploader

  validates_presence_of :image, message: "can not be blank"
end
