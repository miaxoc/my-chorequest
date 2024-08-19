class CreateProgresses < ActiveRecord::Migration[7.1]
  def change
    create_table :progresses do |t|
      t.references :user, null: false, foreign_key: true
      t.references :goodie, null: false, foreign_key: true
      t.string :achievements

      t.timestamps
    end
  end
end
