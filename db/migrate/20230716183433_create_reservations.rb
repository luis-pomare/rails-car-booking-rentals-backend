class CreateReservations < ActiveRecord::Migration[7.0]
  def change
    create_table :reservations do |t|
      t.date :starting_date
      t.date :end_date
      t.string :city
      t.float :cost

      t.timestamps
    end
  end
end
