class CreateCars < ActiveRecord::Migration[7.0]
  def change
    create_table :cars do |t|
      t.string :name
      t.string :description
      t.float :cost_per_day
      t.string :image

      t.timestamps
    end
  end
end
