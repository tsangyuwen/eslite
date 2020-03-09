class Admin::ProductsController < Admin::BaseController
  before_action :get_resource, :check_resource_exists, except: :index
  def index
    @products = Product.all
  end

  def show
  end

  def new
  end

  def create
    update_resource(:create)
  end

  def edit
  end

  def edit_image
  end

  def update
    update_resource(:update)
  end

  def delete
    if @resource.destroy
      redirect_to admin_products_path, notice: "Deleted Successed"
    else
      redirect_to admin_product_path(@resource), error: @resource.errors.full_messages
    end
  end

  private

  def get_resource
    @resource = Product.find_by_id(params[:id]) || Product.new
    @allow_events = @resource.aasm.events(permitted: true).map(&:name)
  end

  def update_resource(render_action_name)
    @resource.assign_attributes(product_params)
    if params["status_event"].blank? || @allow_events.include?(params["status_event"].to_sym)
      @resource.transaction do 
        @resource.save!
        @resource.send("#{params["status_event"]}!") unless params["status_event"].blank?
      end
      redirect_to admin_product_path(@resource), notice: "Created Successed"
    else
      flash.now[:error] = "Invalid Status"
      render :new
    end
  rescue ActiveRecord::RecordInvalid
    flash.now[:error] = @resource.errors.full_messages.join(", ")
    render :new
  end

  def product_params
    params.require(:product).permit(:sku, :name, :desc, :origin_price, :selling_price, 
                                    {product_images: []})
  end
end