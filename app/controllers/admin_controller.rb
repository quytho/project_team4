class AdminController < ApplicationController
  layout :dynamic_layout

  before_action :admins?
  before_action :logged_in_user
  def index; end

  def admins?
    return if current_user.is_admin?

    flash[:danger] = "Không the truy cap"
    redirect_to root_url
  end

  private

  def dynamic_layout
    if current_user.is_admin?
      "admin"
    else
      "users"
    end
  end
end
