class AddColumns < ActiveRecord::Migration[5.1]
  def change
    add_column :users, :charge, :integer
    add_column :bookings, :status, :integer
  end
end
