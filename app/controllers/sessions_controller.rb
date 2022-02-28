class SessionsController < ApplicationController
  before_action :authenticate_user!, only: [:destroy]
  before_action :redirect_if_authenticated, only: %i[create new]

  def new; end

  def create
    @user = User.find_by(email: params[:user][:email].downcase)
    if @user
      if @user.unconfirmed?
        redirect_to new_confirmation_path, alert: "Incorrect email or password."
      elsif @user.authenticate(params[:user][:password])
        login @user
        remember(@user) if params[:user][:remember_me] == "1"
      else
        flash.now[:alert] = "Incorrect email or password."
        render :new, status: :unprocessable_entity
      end
    else
      flash.now[:alert] = "Incorrect email or password."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    forget(current_user)
    logout
    redirect_to root_path, notice: "Signed out."
  end
end
