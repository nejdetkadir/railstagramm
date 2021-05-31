class RemovePublicFromUser < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :public
  end
end
