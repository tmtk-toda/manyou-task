class Label < ApplicationRecord
  has_many :task_labels, dependent: :destroy, foreign_key: 'task_id'
  has_many :tasks, through: :task_labels, source: :task
end
