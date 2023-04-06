class Order < ApplicationRecord
	has_and_belongs_to_many :products
	validates :name, :quantity, :status, presence: true
end
