class UsersController < ApplicationController
  before_action :load_users, only: %i(edit update)

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash[:success] = t ".welcome"
      log_in @user
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @user.update_attributes user_params
      flash[:success] = "Update success"
      redirect_to root_path
    else
      flash[:danger] = "Update fail"
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit :name, :email,
      :password, :password_confirmation
  end

  def load_users
    @user = User.find params[:id]
    return if @user
    flash[:danger] = "User invalid"
    redirect_to root_path
  end
end
