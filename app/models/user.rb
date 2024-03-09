class User < ApplicationRecord
  before_create :password_digest

  def password_digest
    self.password = User.generate_digest(password)
  end

  def self.generate_digest(password)
    salt = "Qdsfaewrtrepo87723gddfa7"
    pass_digest = Digest::MD5.hexdigest(password)
    salt_digest = Digest::MD5.hexdigest(salt)
    Digest::MD5.hexdigest(pass_digest + salt_digest)
  end
end
