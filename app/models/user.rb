class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  before_create :encrypt_password

  has_many :missions, autosave: true, dependent: :destroy

  def self.login(user)
    pw = encrypt_pw(user[:password])
    User.find_by(email: user[:email], password: pw)
  end

  private

  def encrypt_password
    self.password = User.encrypt_pw("#{self.password}")
  end

  def self.encrypt_pw(pwd)
    Digest::SHA1.hexdigest(pwd)
  end
end
