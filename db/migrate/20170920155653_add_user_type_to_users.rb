class AddUserTypeToUsers < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :type, :int, default: 2
  end
end
