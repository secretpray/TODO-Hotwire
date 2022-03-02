require "test_helper"

class SudosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "should get new" do
    get new_sudo_url(proceed_to_url: edit_password_url)
    assert_response :success
  end

  test "should sudo" do
    post sudo_url, params: { password: "Secret123456", proceed_to_url: edit_password_url }
    assert_redirected_to edit_password_url
  end

  test "should not sudo with wrong password" do
    post sudo_url, params: { password: "SecretWrong123", proceed_to_url: edit_password_url }
    assert_redirected_to new_sudo_url(proceed_to_url: edit_password_url)
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); [user, response.headers["X-Session-Token"]]
  end
end
