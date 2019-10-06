class User < ApplicationRecord
  attr_accessor :remember_token
  before_save {email.downcase!}
  validates :name, presence: true, length: {maximum: 50}
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: {maximum: 250}, format: {with: VALID_EMAIL_REGEX}, uniqueness: {case_sensitive: false}
  has_secure_password
  validates :password, presence: true, length: {minimum: 6}
  
  #渡された文字列のハッシュ値を返す
  def User.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを作成
  def User.new_token
    SecureRandom.urlsafe_base64
  end
  
  #トークンを属性、DBに保存
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token) )
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
   #トークンが一致するかどうか
  def authenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(remember_digest).is_password?(remember_token)
  end
end