class Jsake < ApplicationRecord
  
  validates :meigara, presence: true
  validates :image_url, presence: true
  validates :seimai_buai, presence: true
  validates :locaility, presence: true
  validates :alcohol_degree, presence: true
  
  belongs_to :user
  
  mount_uploader :image_url, ImageUploader
  
  has_many :favorites
  
end
