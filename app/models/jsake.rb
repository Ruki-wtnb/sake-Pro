class Jsake < ApplicationRecord
  
  mount_uploader :image_url, ImageUploader
  #必須の制御
  validates :meigara, presence: true 
  validates :seimai_buai, presence: true
  validates :locaility, presence: true
  validates :alcohol_degree, presence: true
  
  belongs_to :user 
  has_one_attached :image
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  has_many :comments
  has_many :votes
  
end
