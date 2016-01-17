class AddTimeEstimateToUberWorldDatum < ActiveRecord::Migration
  def change
    add_column :uber_world_data, :wait_time, :integer
  end
end
