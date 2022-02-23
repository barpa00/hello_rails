class User < ApplicationRecord
  has_many :missions, autosave: true
end
