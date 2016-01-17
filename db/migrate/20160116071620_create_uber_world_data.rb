class CreateUberWorldData < ActiveRecord::Migration
  def change
    create_table :uber_world_data do |t|
      t.float :distance
      t.string :estimate
      t.string :ride_type
      t.float :surge_multiplier
      t.string :city

      t.timestamps null: false
    end
  end
end
