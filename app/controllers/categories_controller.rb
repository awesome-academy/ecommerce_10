class CategoriesController < ApplicationController
  before_action :load_categories, only: %i(index show)

  def index
    @products = Product.order(:name).paginate page: params[:page],
      per_page: Settings.paginate_view_home
  end

  def show
    @category = Category.find_by id: params[:id]
    return unless @category
    @list_products_by_category = @category.products
  end

  private

  def load_categories
    @categories = Category.sort_by_name
  end
end
