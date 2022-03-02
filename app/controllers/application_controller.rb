class ApplicationController < ActionController::Base
  before_action :authenticate

  def authenticate
    if session = Session.find_by_id(cookies.signed[:session_token])
      Current.session = session
    else
      redirect_to sign_in_path
    end
  end

  def require_sudo
    if Current.session.sudo_at < 30.minutes.ago
      redirect_to new_sudo_path(proceed_to_url: request.url)
    end
  end
end
