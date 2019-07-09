class Admin::BaseController < ApplicationController
  before_action :verify_admin

  private

  def verify_admin
    return if current_user.try :admin?
    flash[:danger] = t "reject_access"
    redirect_to root_url
  end
end
