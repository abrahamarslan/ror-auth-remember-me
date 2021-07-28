require "test_helper"

class AuthenticationTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  def setup
    #@user = users(:test)
  end

  test "test the login with invalid information" do
    get login_path
    assert_template 'authentication/login'
    post login_path, params: {user: {email: '', password: ''}}
    assert_template "authentication/login"
    assert_not flash.empty?
  end

  test "test the login with valid information" do
    get login_path
    post login_path, params: {user: {email: @user.email, password: 'password'}}
    assert_redirected_to @user
    follow_redirect!
    assert_template 'user/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
  end

  test "sign-up test with valid information" do
    get signup_path
    assert_difference 'User.count', 1 do
      post signup_path, params: {user: {name: "Testing user", email: "email@user.com", password: "password", password_confirmation: "password"}}
      follow_redirect!
    end
    assert_template 'user/show'
    assert is_logged_in?
  end

  test "logout feature" do
    get logout_path
    assert_redirected_to root_url
    assert !is_logged_in?
  end

end
