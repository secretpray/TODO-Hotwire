class RegistrationsController < ApplicationController
  skip_before_action :authenticate, only: %i[ new create ]

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)

    if @user.save
      session = @user.sessions.create!(session_params)
      cookies.signed.permanent[:session_token] = { value: session.id, httponly: true }

      redirect_to root_path, notice: "Welcome! You have signed up successfully"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    Current.user.destroy; redirect_to(sign_in_path, notice: "Your account is closed")
  end

  private
    def user_params
      params.require(:user).permit(:email, :password, :password_confirmation)
    end

    def session_params
      { user_agent: request.user_agent, ip_address: request.remote_ip, sudo_at: Time.current }
    end
end
