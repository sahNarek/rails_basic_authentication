class AddLoggedFlagToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :logged, :boolean
  end
end
