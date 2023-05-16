class Order < ApplicationRecord
  validates :name, :quantity, presence: true

	belongs_to :user
	has_and_belongs_to_many :products
end