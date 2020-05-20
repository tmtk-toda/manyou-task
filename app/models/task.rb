class Task < ApplicationRecord
  validates :name, presence: true
  validates :detail, presence: true
  validates :deadline, presence: true
  validates :completed, presence: true
  validates :priority, presence: true
  enum completed: { 未着手: 0, 着手中: 1, 完了: 2 }
  enum priority: { 低: 0, 中: 1, 高: 2 }
  scope :search_name, -> (name) { where('name LIKE ?', "%#{name}%") if name.present? }
  scope :search_completed, -> (completed) { where(completed: completed) if completed.present? }
  belongs_to :user
end