class Jsake < ApplicationRecord
  
  validates :meigara, presence: true
  
  validates :seimai_buai, presence: true
  validates :locaility, presence: true
  validates :alcohol_degree, presence: true
  
  belongs_to :user
  
  has_one_attached :image
  
  
  has_many :favorites
  has_many :favorite_users, through: :favorites, source: 'user'
  
  has_many :comments
  
end
