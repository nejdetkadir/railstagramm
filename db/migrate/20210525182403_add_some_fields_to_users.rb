class AddSomeFieldsToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :username, :string
    add_column :users, :fullname, :string
    add_column :users, :bio, :string
    add_column :users, :website, :string
    add_column :users, :profile, :string
    add_column :users, :birthday, :date
    add_column :users, :gender, :string
    add_column :users, :public, :boolean, default: true
    add_column :users, :slug, :string

    add_index :users, :slug, unique: true
  end
end
