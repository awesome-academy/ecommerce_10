class Admin::ProductsController < ApplicationController
  layout "application_admin"
  before_action :load_admin_products, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.product_active.paginate page: params[:page],
      per_page: Settings.admin.product_limit
  end

  def new
    @product = Product.new
  end

  def edit; end

  def create
    @product = Product.new admin_product_params
    if @product.save
      flash[:success] = t "admin.create_success"
      redirect_to admin_products_path
    else
      flash[:danger] = t "admin.create_fail"
      render :new
    end
  end

  def update
    if @product.update_attributes admin_product_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_categories_path
      redirect_to admin_products_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
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
    params.require(:product).permit :name, :description, :quantity,
      :price, :status, :category_id
  end
end
