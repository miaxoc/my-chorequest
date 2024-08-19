class CreateTasks < ActiveRecord::Migration[7.1]
  def change
    create_table :tasks do |t|
      t.string :category
      t.string :title
      t.string :description
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.references :task_list, null: false, foreign_key: true

      t.timestamps
    end
  end
end
