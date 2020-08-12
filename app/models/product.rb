class Product < ApplicationRecord

  belongs_to :user
  belongs_to :order
  has_one :address
  has_one_attached :image
end
