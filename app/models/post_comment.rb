class PostComment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user } 
end
