class PasswordResetsController < ApplicationController
  skip_before_action :authenticate

  before_action :set_user, only: %i[ edit update ]

  def new; end

  def edit; end

  def create
    if @user = User.find_by(email: params[:email], verified: true)
      IdentityMailer.with(user: @user).password_reset_provision.deliver_later
      redirect_to sign_in_path, notice: "Check your email for reset instructions"
    else
      redirect_to new_password_reset_path, alert: "You can't reset your password until you verify your email"
    end
  end

  def update
    if @user.update(user_params)
      redirect_to sign_in_path, notice: "Your password was reset successfully. Please sign in"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  private
    def set_user
      @user = User.find_signed!(params[:token], purpose: :password_reset)
    rescue
      redirect_to new_password_reset_path, alert: "That password reset link is invalid"
    end

    def user_params
      params.require(:user).permit(:password, :password_confirmation)
    end
end
