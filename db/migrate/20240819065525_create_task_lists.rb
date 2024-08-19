class CreateTaskLists < ActiveRecord::Migration[7.1]
  def change
    create_table :task_lists do |t|
      t.references :household, null: false, foreign_key: true

      t.timestamps
    end
  end
end
