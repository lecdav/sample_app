# frozen_string_literal: true
require 'test_helper'

class UserControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:michael)
    @other_user = users(:archer)
  end
  
  test 'should get new' do
    get signup_path
    assert_response :success
    # assert_select "title", "Sign up #{base_title}"
  end

  test 'should create a user and display a welcome message' do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { name: 'David',
                                          email: 'david@david.dv',
                                          password: 'goodpass',
                                          password_confirmation: 'goodpass' } }                                        
    end
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { name: @user.name,
                                              email: @user.email } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirectu index if not logged" do
    get users_path
    assert_redirected_to login_path
  end
end
