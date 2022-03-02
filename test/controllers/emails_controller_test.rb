require "test_helper"

class EmailsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
  end

  test "should get edit" do
    get edit_email_url
    assert_response :success
  end

  test "should not get edit without sudo" do
    @user.sessions.last.update! sudo_at: 1.day.ago

    get edit_email_url
    assert_redirected_to new_sudo_path(proceed_to_url: edit_email_url)
  end

  test "should update email" do
    patch email_url, params: { user: { email: "new_email@hey.com" } }
    assert_redirected_to root_path
  end

  test "should not update email without sudo" do
    @user.sessions.last.update! sudo_at: 1.day.ago

    patch email_url, params: { user: { email: "new_email@hey.com" } }
    assert_redirected_to new_sudo_path(proceed_to_url: email_url)
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); user
  end
end
