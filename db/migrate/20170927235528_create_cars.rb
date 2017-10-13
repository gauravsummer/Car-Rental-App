class CreateCars < ActiveRecord::Migration[5.1]
  def change
    create_table :cars, force: :cascade do |t|
      t.string :model
      t.text :description
      t.string :license_number
      t.string :manufacturer
      t.string :style
      t.float :price
      t.string :status, default: 'Available'
      t.string :location
      t.timestamps
    end
  end
end
