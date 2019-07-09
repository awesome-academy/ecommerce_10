class Admin::CategoriesController < Admin::BaseController
  layout "application_admin"
  before_action :load_admin_categories, except: %i(new index create)

  def index
    @categories = Category.paginate page: params[:page],
      per_page: Settings.categories_admin
  end

  def new
    @category = Category.new
  end

  def edit; end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t "admin.create_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.create_fail"
      render :new
    end
  end

  def update
    if @category.update_attributes category_params
      flash[:success] = t "admin.update_success"
      redirect_to admin_categories_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  def destroy
    if @category.destroy
      flash[:success] = t "admin.delete_success"
    else
      flash[:danger] = t "admin.delete_fail"
    end
    redirect_to admin_categories_path
  end

  private

  def load_admin_categories
    @category = Category.find params[:id]
    return if @category
    flash[:danger] = t "category.not_found"
    redirect_to admin_categories_path
  end

  def category_params
    params.require(:category).permit :name_category, :description
  end
end
