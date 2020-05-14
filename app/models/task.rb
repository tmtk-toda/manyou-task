class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  enum completed: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
end