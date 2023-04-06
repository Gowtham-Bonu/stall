class Product < ApplicationRecord
  validates :name, :cost, presence: true
  has_and_belongs_to_many :orders
end
