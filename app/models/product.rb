class Product < ApplicationRecord
  validates :name, :cost, presence: true
  has_one :order, dependent: :destroy
end
