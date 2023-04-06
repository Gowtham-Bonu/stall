class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :name
      t.integer :cost
      t.string :brand
      t.boolean :availability
      t.belongs_to :user
      t.timestamps
    end
  end
end
