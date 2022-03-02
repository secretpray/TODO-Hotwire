require "application_system_test_case"

class PasswordResetsTest < ApplicationSystemTestCase
  setup do
    @user = users(:lazaro_nixon)
    @sid = @user.signed_id(purpose: :password_reset, expires_in: 20.minutes)
  end

  test "sending a password reset email" do
    visit sign_in_url
    click_on "Forgot your password?"

    fill_in "Email", with: @user.email
    click_on "Send password reset email"

    assert_text "Check your email for reset instructions"
  end

  test "updating password" do
    visit edit_password_reset_url(token: @sid)

    fill_in "New password", with: "Secret654321"
    fill_in "Confirm new password", with: "Secret654321"
    click_on "Save changes"

    assert_text "Your password was reset successfully. Please sign in"
  end
end
