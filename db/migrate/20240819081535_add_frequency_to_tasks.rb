class AddFrequencyToTasks < ActiveRecord::Migration[7.1]
  def change
    add_column :tasks, :frequency, :integer
  end
end
