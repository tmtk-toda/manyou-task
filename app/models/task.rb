class Task < ApplicationRecord
  default_scope -> { order(created_at: :desc) }
  validates :name, presence: true
  validates :detail, presence: true
end
