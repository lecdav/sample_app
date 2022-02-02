require 'test_helper'

class SessionsHelperTest < ActionView::TestCase
  def setup
    @user = users(:michael)
    remember(@user)
  end

  test 'current_user returns right user when session is nil' do
    assert_equal @user, current_user
    assert is_logged_in? # "current_user.inspect : #{current_user.inspect} \n" + 
                          # "session[:user_id].nil? : #{session[:user_id].nil?} \n" +
                          # "cookies.encrypted[:user_id] : #{cookies.encrypted[:user_id]} \n" +
                          # "@user.id : #{@user.id} \n " +
                          # "User.find_by(id: @user.id) : #{User.find_by(id: @user.id).inspect} \n" +
                          # "cookies.encrypted[:remember_token] : #{cookies.encrypted[:remember_token]} \n" +
                          # "User.find_by(id: @user.id).authenticated?(cookies.encrypted[:remember_token]) : #{User.find_by(id: @user.id).authenticated?(cookies.encrypted[:remember_token])}"
  end

  test 'current_user returns nil when remember_digest is wrong' do
    @user.update_attribute(:remember_digest, User.digest(User.new_token))
    assert_nil current_user
  end
end