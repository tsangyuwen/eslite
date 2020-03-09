class CreateProduct < ActiveRecord::Migration[6.0]
  def change
    create_table :products do |t|
      t.string :sku, unique: true
      t.string :name
      t.text :desc
      t.string :status, default: "purchasing"
      t.string :product_images
      t.integer :origin_price
      t.integer :selling_price
      t.timestamps
    end
  end
end
