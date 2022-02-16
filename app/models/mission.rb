class Mission < ApplicationRecord
  validates :title, presence: { message: I18n.t('title.error') }
  default_scope { order(created_at: :DESC) }
end
