class User < ApplicationRecord
  attr_accessor :remember_token
  
  validates :name, presence: true, length:{maximum:15}
                      
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  
  VALID_PASSWORD_REGEX = /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i
  validates :password, length:{in: 8..32}, format: { with: VALID_PASSWORD_REGEX }
  
  has_secure_password
  
  has_many :jsakes
  
  has_many :favorites
  has_many :favorite_jsakes, through: :favorites, source: 'jsake'
  
  has_many :search_histories
  
  has_many :comments
  
  # 渡された文字列のハッシュ値を返す
  def self.digest(string)
    cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
                                                  BCrypt::Engine.cost
    BCrypt::Password.create(string, cost: cost)
  end
  
  #ランダムなトークンを返す
  def self.new_token
    SecureRandom.urlsafe_base64
  end
  
  def remember
    self.remember_token = User.new_token #ランダムなトークンの実行結果を属性に代入する
    update_attribute(:remember_digest, remember_token)#バリデーションを無視してトークンを保存
  end
  
  def authenticated?(remember_token)
    return false if remember_digest.nil? 
    remember_digest == remember_token
  end
  
  def forget
    update_attribute(:remember_digest, nil)
  end
  
end
