class CreateUberNewYearsData < ActiveRecord::Migration
  def change
    create_table :uber_new_years_data do |t|
      t.string :ride_type
      t.string :neighborhood
      t.float :surge_multiplier
      t.integer :time_estimate

      t.timestamps null: true
    end
  end
end
