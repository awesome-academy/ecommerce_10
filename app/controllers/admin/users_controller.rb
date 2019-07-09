class Admin::UsersController < Admin::BaseController
  layout "application_admin"
  load_and_authorize_resource
  before_action :load_user, only: %i(edit destroy update)

  def index
    @users = User.user_activated.paginate page: params[:page],
      per_page: Settings.admin_user
  end

  def edit; end

  def update
    if @user.update_attributes user_param
      flash[:success] = t "admin.update_success"
      redirect_to admin_users_path
    else
      flash[:danger] = t "admin.update_fail"
      render :edit
    end
  end

  def destroy
    if @user.update_attribute :activated, false
      flash[:success] = t "admin.delete_success"
      execute_del_user @user
    else
      flash[:danger] = t "admin.delete_fail"
    end
    redirect_to admin_users_path
  end

  private

  def user_param
    params.require(:user).permit :name, :email, :password,
      :password_confirmation, :role
  end

  def load_user
    @user = User.find_by id: params[:id]
    return if @user
    flash[:danger] = t "admin.user_invalid"
    redirect_to admin_users_path
  end
end
