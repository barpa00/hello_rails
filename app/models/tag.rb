class Tag < ApplicationRecord
  has_many :missions_tags
  has_many :missions, through: :missions_tags
end
