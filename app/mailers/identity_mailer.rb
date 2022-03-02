class IdentityMailer < ApplicationMailer
  def password_reset_provision
    @user = params[:user]
    @signed_id = @user.signed_id(purpose: :password_reset, expires_in: 20.minutes)

    mail to: @user.email, subject: "Reset your password"
  end

  def email_verify_confirmation
    @user = params[:user]
    @signed_id = @user.signed_id(purpose: @user.email, expires_in: 3.days)

    mail to: @user.email, subject: "Verify your email"
  end
end
