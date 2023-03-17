class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.string :name
      t.integer :quantity
      t.string :status
      t.belongs_to :product

      t.timestamps
    end
  end
end
