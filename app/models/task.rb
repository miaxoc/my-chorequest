class Task < ApplicationRecord
  belongs_to :player
  belongs_to :task_list
end
