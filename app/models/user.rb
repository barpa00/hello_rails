class User < ApplicationRecord
  validates :email, presence: true, uniqueness: true
  validates :password, presence: true, confirmation: true

  before_create :encrypt_password
  before_destroy :check_admin_num

  has_many :missions, autosave: true, dependent: :destroy

  enum roles: { user: 0, admin: 1 }

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

  def check_admin_num
    return if self.user?
    return if User.admin.size > 1

    throw :abort
  end
end
 