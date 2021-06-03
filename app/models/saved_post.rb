class SavedPost < ApplicationRecord
  belongs_to :user
  belongs_to :post

  include PublicActivity::Model
  tracked owner: Proc.new{ |controller, model| controller.current_user }, params: {user_id: Proc.new{ |controller, model| model.post.user_id }}
end
