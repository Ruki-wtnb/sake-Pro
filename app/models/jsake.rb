class Jsake < ApplicationRecord
  
  validates :meigara, presence: true
  validates :image_url, presence: true
  validates :seimai_buai, presence: true
  validates :locaility, presence: true
  validates :alcohol_degree, presence: true
  
  belongs_to :user
  
  has_one_attached :image_url
  #mount_uploader :image_url, ImageUploader
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  
  has_many :comments
  
end
