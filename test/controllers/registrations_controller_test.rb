require "test_helper"

class RegistrationsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get sign_up_url
    assert_response :success
  end

  test "should sign up" do
    assert_difference("User.count") do
      post sign_up_url, params: { user: { email: "lazaronixon@hey.com", password: "Secret123456", password_confirmation: "Secret123456" } }, headers: { "User-Agent" => "Firefox" }
    end

    assert_redirected_to root_url
  end

  test "should destroy account" do
    sign_in_as users(:lazaro_nixon)

    assert_difference("User.count", -1) do
      delete registration_path
    end

    assert_redirected_to sign_in_url
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); user
  end
end
