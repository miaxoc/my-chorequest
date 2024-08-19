class CreateGoodies < ActiveRecord::Migration[7.1]
  def change
    create_table :goodies do |t|
      t.string :name
      t.string :type
      t.integer :cost
      t.string :location
      t.string :placement
      t.integer :status

      t.timestamps
    end
  end
end
