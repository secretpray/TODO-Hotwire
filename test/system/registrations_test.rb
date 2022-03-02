require "application_system_test_case"

class RegistrationsTest < ApplicationSystemTestCase
  setup do
    @user = users(:lazaro_nixon)
  end

  test "signing up" do
    visit sign_up_url

    fill_in "Email", with: "lazaronixon@hey.com"
    fill_in "Password", with: "Secret654321"
    fill_in "Password confirmation", with: "Secret654321"
    click_on "Sign up"

    assert_text "Welcome! You have signed up successfully"
  end

  test "cancelling my account" do
    sign_in_as @user

    click_on "Cancel my account & delete my data"
    assert_text "Your account is closed"
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
