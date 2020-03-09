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
  end

  def update_resource(render_action_name)
    @resource.transaction do 
      @resource.update!(product_params.except(:status))
      @resource.send("#{product_params[:status]}!")
    end
    redirect_to admin_product_path(@resource), notice: "Created Successed"
  rescue ActiveRecord::RecordInvalid
    puts @resource.errors.full_messages
    render :new, error: @resource.errors.full_messages
  end

  def product_params
    params.require(:product).permit(:sku, :name, :desc, :status, :origin_price, :selling_price)
  end
end