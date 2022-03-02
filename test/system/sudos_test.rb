require "application_system_test_case"

class SudosTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "executing sudo" do
    visit new_sudo_url(proceed_to_url: edit_password_url)
    fill_in :password, with: "Secret123456"
    click_on "Continue"

    assert_selector "h1", text: "Change your password"
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
