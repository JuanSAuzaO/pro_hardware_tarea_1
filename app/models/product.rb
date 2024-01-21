class Product < ApplicationRecord
  validates :name, presence: true, length: { minimum: 3, maximum: 64 }
  validates :description, presence: true, length: { minimum:20, maximum: 512 }
  validates :price_cents, numericality: { only_integer: true, greater_than: 0 } 
end
