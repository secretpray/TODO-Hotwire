require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:lazaro_nixon)
  end

  test "should get index" do
    sign_in_as @user

    get sessions_url
    assert_response :success
  end

  test "should get new" do
    get sign_in_url
    assert_response :success
  end

  test "should sign in" do
    post sign_in_url, params: { email: @user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }
    assert_enqueued_email_with SessionMailer, :signed_in_notification, args: { session: @user.sessions.last }

    assert_redirected_to root_url

    get root_url
    assert_response :success
  end

  test "should not sign in with wrong credentials" do
    post sign_in_url, params: { email: @user.email, password: "SecretWrong123" }, headers: { "User-Agent" => "Firefox" }
    assert_redirected_to sign_in_url(email_hint: @user.email)
    assert_equal "That email or password is incorrect", flash[:alert]

    get root_url
    assert_redirected_to sign_in_path
  end

  test "should sign out" do
    sign_in_as @user

    delete session_url(@user.sessions.last)
    assert_redirected_to sessions_path

    follow_redirect!
    assert_redirected_to sign_in_path
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); user
  end
end
