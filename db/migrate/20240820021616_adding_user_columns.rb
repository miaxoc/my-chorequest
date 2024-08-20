class AddingUserColumns < ActiveRecord::Migration[7.1]
  def change
    add_reference :users, :household, foreign_key: true
  end
end
