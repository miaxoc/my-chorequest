class AddDeadlineToSubmissions < ActiveRecord::Migration[7.1]
  def change
    add_column :submissions, :deadline, :date
  end
end
