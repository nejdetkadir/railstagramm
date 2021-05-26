class RenameTypeOfFriendshipModel < ActiveRecord::Migration[6.1]
  def change
    rename_column :friendships, :type, :status
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
