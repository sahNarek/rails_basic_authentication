class AddUniqueIndexToUsers < ActiveRecord::Migration[6.0]
  def change
    change_column :users, :email, unique: true
  end
end
