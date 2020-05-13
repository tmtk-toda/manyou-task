class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  enum completed: { 未着手: 0, 着手: 1, 完了: 2 }
  enum priority: { 高: 0, 中: 1, 低: 2 }
end