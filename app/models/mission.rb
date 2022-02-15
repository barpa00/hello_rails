class Mission < ApplicationRecord
  validates :title, presence: true
  default_scope { order(created_at: :DESC) }
end
