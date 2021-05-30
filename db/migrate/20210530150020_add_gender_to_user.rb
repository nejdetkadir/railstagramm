class AddGenderToUser < ActiveRecord::Migration[6.1]
  def change
    add_reference :users, :gender, null: false, foreign_key: true
  end
end
