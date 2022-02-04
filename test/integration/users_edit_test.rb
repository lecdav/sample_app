require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @user = users(:michael)
  end

  test "unsuccessful edit" do
    log_in_as(@user) # Be carefull, 2 versions of log_in_as method, depending of the test class
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path(@user), params: { user: { name: "",
                                              email: "foo@invalid",
                                              password:              "foo",
                                              password_confirmation: "bar"} }
    assert_template "users/edit"
    assert_select "div.alert", "The form contains 5 errors."
    assert_select 'li', "Name can't be blank"
    assert_select 'li', 'Name is too short (minimum is 1 character)'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password is too short (minimum is 6 characters)'
    assert_select 'li', "Password confirmation doesn't match Password"
  end

  test "successful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end

  test "successful edit with friendly forwarding" do
    # try to edit user without being logged in
    get edit_user_path(@user)
    # check if forwarding url has been stored
    assert_not_nil session[:forwarding_url]
    log_in_as(@user) # Be carefull, 2 versions of log_in_as method, depending of the test class
    assert_redirected_to edit_user_url(@user)
    # edit user's info
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    # check that friendly forwarding forwards just the first time
    assert_nil session[:forwarding_url]
    # check if user's infos have correctly been changed
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
