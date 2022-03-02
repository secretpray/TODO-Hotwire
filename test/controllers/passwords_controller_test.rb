require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "should get edit" do
    get edit_password_url
    assert_response :success
  end

  test "should update password" do
    patch password_url, params: { current_password: "Secret123456", user: { password: "Secret654321", password_confirmation: "Secret654321" } }
    assert_redirected_to root_path
  end

  test "should not update password with wrong current password" do
    patch password_url, params: { current_password: "SecretWrong123", user: { password: "Secret654321", password_confirmation: "Secret654321" } }

    assert_redirected_to edit_password_path
    assert_equal "The current password you entered is incorrect", flash[:alert]
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); user
  end
end
