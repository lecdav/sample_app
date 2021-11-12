require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test 'invalid sign-up information' do
    assert_no_difference "User.count" do
      post users_path, params: { user: { name: '',
                                         email: 'invalid@mail',
                                         password: 'short',
                                         password_confirmation: '' } }
    end
  end
  
  test 'invalid inputs error messages presence' do
    post users_path, params: { user: { name: '',
                                       email: 'invalid@mail',
                                       password: 'short',
                                       password_confirmation: '' } }
    assert_select 'li', "Name can't be blank"
    assert_select 'li', 'Name is too short (minimum is 1 character)'
    assert_select 'li', 'Email is invalid'
    assert_select 'li', 'Password is too short (minimum is 6 characters)'
    assert_select 'li', "Password confirmation doesn't match Password"
  end


end
