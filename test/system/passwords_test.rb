require "application_system_test_case"

class PasswordsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "updating the password" do
    click_on "Change password"

    fill_in "Current password", with: "Secret123456"
    fill_in "New password", with: "Secret654321"
    fill_in "Confirm new password", with: "Secret654321"
    click_on "Save changes"

    assert_text "Your password has been changed"
  end

  def sign_in_as(user)
    visit sign_in_url
    fill_in :email, with: user.email
    fill_in :password, with: "Secret123456"
    click_on "Sign in"

    assert_current_path root_path
    return user
  end
end
