class RenamePointsToWaterLevelInUsers < ActiveRecord::Migration[7.1]
  def change
    rename_column :users, :points, :water_level
  end
end
