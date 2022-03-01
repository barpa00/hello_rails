class Mission < ApplicationRecord
  belongs_to :user
  paginates_per 10
  
  validates :title, presence: { message: I18n.t('title.error') }
  default_scope { order(created_at: :DESC) }
  enum status: { norush: 0, medium: 1, priority: 2 }
  
  include AASM
  aasm do 
    state :doing, initial: true
    state :processing, :finishing

    event :todo do 
      transitions from: :doing, to: :processing
    end
    event :done do 
      transitions from: :processing, to: :finishing
    end
    event :undo do 
      transitions from: :finishing, to: :processing
    end
  end
end
