class Mission < ApplicationRecord
  belongs_to :user
  has_many :missions_tags
  has_many :tags, through: :missions_tags

  paginates_per 10
  
  validates :title, presence: { message: I18n.t('title.error') }
  default_scope { order(created_at: :DESC) }
  enum status: { norush: 0, medium: 1, priority: 2 }
  
  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.find_or_create_by(name: name)
    end
  end

  def all_tags
    tags.map(&:name).join(',')
  end

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
