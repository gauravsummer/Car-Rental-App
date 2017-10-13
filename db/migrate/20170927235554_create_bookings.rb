class CreateBookings < ActiveRecord::Migration[5.1]
  def change
    create_table :bookings, force: :cascade do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.references :user
      t.references :car
      t.timestamps
    end
  end
end
