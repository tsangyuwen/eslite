class Admin::ImagesController < Admin::BaseController
  before_action :get_product

  def create
    if params[:product].present?
      add_more_images(images_params[:product_images])
    end
    flash[:error] = "Failed uploading images" unless @product.save
    redirect_to edit_image_admin_product_path(@product)
  end

  def destroy
    remove_image_at_index(params[:id].to_i)
    flash[:error] = "Failed deleting image" unless @product.save
    redirect_to edit_image_admin_product_path(@product)
  end
  
  private
  def get_product
    @product = Product.find_by_id(params[:product_id])
  end

  def add_more_images(new_images)
    images = @product.product_images
    images += new_images
    @product.product_images = images
  end

  def remove_image_at_index(index)
    remain_images = @product.product_images
    if index == 0 && @product.product_images == 1
      @product.remove_product_images!
    else
      deleted_image = remain_images.delete_at(index)
      deleted_image.try(:remove!)
      @product.product_images = remain_images
    end
  end

  def images_params
    params.require(:product).permit({product_images: []})
  end
end