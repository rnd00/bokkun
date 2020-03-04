class CreateTrips < ActiveRecord::Migration[5.2]
  def change
    create_table :trips do |t|
      t.string :name
      t.string :destination
      t.string :purpose
      t.string :customer
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
