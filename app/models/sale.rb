class Sale < ApplicationRecord
  validates :seller_id, presence: true
  validates :product_id, presence: true
  validates :price, presence: true
end
