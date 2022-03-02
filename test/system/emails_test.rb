require "application_system_test_case"

class EmailsTest < ApplicationSystemTestCase
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "updating the email" do
    click_on "Change email address"

    fill_in "New email", with: "new_email@hey.com"
    click_on "Save changes"

    assert_text "Your email has been changed"
  end

  test "sending a verification email" do
    @user.update! verified: false

    click_on "Change email address"
    click_on "Re-send verification email"

    assert_text "We sent a verification email to your email address"
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
