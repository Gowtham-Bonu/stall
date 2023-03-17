class Order < ApplicationRecord
	belongs_to :product

	validates :name, :quantity, :status, presence: true
end
