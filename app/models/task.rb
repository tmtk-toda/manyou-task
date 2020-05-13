class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  enum completed: { 未着手: 0, 着手: 1, 完了えx: 2 }
end
