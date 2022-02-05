# frozen_string_literal: true
require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test 'the truth' do
  #   assert true
  # end
  def setup
    @user = users(:michael)
  end
  
  test 'layout links' do
    get root_path
    assert_template 'static_pages/home'
    assert_select 'a[href=?]', root_path, count: 2
    # header specific
      # if not logged in
    assert_select 'a[href=?]', help_path
    assert_select 'a[href=?]', login_path
      # if logged in
    log_in_as(@user)
    assert_redirected_to @user
    get root_path # I don't understand why is it necessary to get root to make the test pass as log_in_as post to login_path that calls the session create action that redirects to @user so the layout should be reloaded
    assert_select 'a[href=?]', user_path(@user)
    assert_select 'a[href=?]', edit_user_path(@user)
    assert_select 'a[href=?]', logout_path
    # footer specific
    assert_select 'a[href=?]', about_path
    assert_select 'a[href=?]', contact_path
    assert_select 'a[href=?]', "https://news.railstutorial.org/"
  end
end
