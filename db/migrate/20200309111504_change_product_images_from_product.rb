class ChangeProductImagesFromProduct < ActiveRecord::Migration[6.0]
  def change
    remove_column :products, :product_images, :string
    add_column :products, :product_images, :json
  end
end
