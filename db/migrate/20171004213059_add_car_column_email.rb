class AddCarColumnEmail < ActiveRecord::Migration[5.1]
  def change
    add_column :cars, :email_register, :boolean
  end
end
