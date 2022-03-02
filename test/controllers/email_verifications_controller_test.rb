require "test_helper"

class EmailVerificationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = sign_in_as(users(:lazaro_nixon))
    @sid = @user.signed_id(purpose: @user.email, expires_in: 20.minutes)
    @sid_exp = @user.signed_id(purpose: @user.email, expires_in: 0.minutes)

    @user.update! verified: false
  end

  test "should send a verification email" do
    assert_enqueued_email_with IdentityMailer, :email_verify_confirmation, args: { user: @user } do
      post email_verification_url
    end

    assert_redirected_to root_path
  end

  test "should verify email" do
    get edit_email_verification_url(token: @sid, email: @user.email)
    assert_redirected_to root_path
  end

  test "should not verify email with expired token" do
    get edit_email_verification_url(token: @sid_exp, email: @user.email)

    assert_redirected_to edit_email_path
    assert_equal "That email verification link is invalid", flash[:alert]
  end

  test "should not verify email with previous token" do
    @user.update! email: "other_email@hey.com"

    get edit_email_verification_url(token: @sid, email: @user.email_previously_was)

    assert_redirected_to edit_email_path
    assert_equal "That email verification link is invalid", flash[:alert]
  end

  def sign_in_as(user)
    post(sign_in_url, params: { email: user.email, password: "Secret123456" }, headers: { "User-Agent" => "Firefox" }); user
  end
end
