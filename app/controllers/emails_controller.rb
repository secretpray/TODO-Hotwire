class EmailsController < ApplicationController
  before_action :require_sudo
  before_action :set_user

  def edit; end

  def update
    if @user.update(user_params)
      redirect_to root_path, notice: "Your email has been changed"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = Current.user
    end

    def user_params
      params.require(:user).permit(:email)
    end
end
