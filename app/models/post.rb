class Post < ApplicationRecord
  belongs_to :user

  mount_uploader :image, PostUploader

  validates_presence_of :image
end
