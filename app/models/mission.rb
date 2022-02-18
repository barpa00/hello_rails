class Mission < ApplicationRecord
  validates :title, presence: { message: I18n.t('title.error') }
  default_scope { order(created_at: :DESC) }
  enum status: { norush: 0, medium: 1, priority: 2 }
end
