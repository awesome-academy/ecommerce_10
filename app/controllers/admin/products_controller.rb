class Admin::ProductsController < Admin::BaseController
  layout "application_admin"
  before_action :load_admin_products, only: [:show, :edit, :update, :destroy]

  def index
    @search = Product.search params[:q]
    @products = @search.result.product_active.paginate page: params[:page],
      per_page: Settings.admin.product_limit
  end

  def new
    @product = Product.new
    @image = @product.images.build
  end

  def edit; end

  def create
    Product.transaction do
      @product = Product.new admin_product_params
      @product.save
      params[:images]["url_path"].each do |a|
        @image = @product.images.create!(url_path: a)
      end
    end
    flash[:success] = t "admin.update_success"
    redirect_to admin_products_path
  rescue StandardError
    flash[:danger] = t "admin.update_fail"
    render :edit
  end

  def update
    Product.transaction do
      @product.update_attributes admin_product_params
      params[:images]["url_path"].each do |a|
        @image = @product.images.create!(url_path: a)
      end
    end
    flash[:success] = t "admin.update_success"
    redirect_to admin_products_path
  rescue StandardError
    flash[:danger] = t "admin.update_fail"
    render :edit
  end

  def destroy
    if @product.update_attribute :status, :deleted
      flash[:danger] = t "admin.delete_success"
    else
      flash[:danger] = t "admin.delete_fail"
    end
    redirect_to admin_products_path
  end

  private

  def load_admin_products
    @product = Product.find params[:id]
    return if @product
    flash[:danger] = t "product.invalid"
    redirect_to admin_products_path
  end

  def admin_product_params
    params.require(:product).permit(:name, :description, :quantity,
      :price, :status, :category_id,
      images_attributes: [:id, :url_path])
  end
end
