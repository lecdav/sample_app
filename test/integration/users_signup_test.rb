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
    assert_select "li", "Name can't be blank"
  end


end
