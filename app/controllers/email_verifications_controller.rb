class EmailVerificationsController < ApplicationController
  skip_before_action :authenticate, only: :edit
  
  before_action :set_user, only: :edit

  def edit
    @user.update! verified: true
    redirect_to root_path, notice: "Thank you for verifying your email address"
  end

  def create
    IdentityMailer.with(user: Current.user).email_verify_confirmation.deliver_later
    redirect_to root_path, notice: "We sent a verification email to your email address"
  end

  private
    def set_user
      @user = User.where(email: params[:email]).find_signed!(params[:token], purpose: params[:email])
    rescue
      redirect_to edit_email_path, alert: "That email verification link is invalid"
    end
end
