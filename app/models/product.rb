class Product < ApplicationRecord
  validates :name, :cost, presence: true

  has_and_belongs_to_many :orders
  belongs_to :user
end
