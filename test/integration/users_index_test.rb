require "test_helper"

class UsersIndexTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  def setup
    @admin     = users(:michael)
    @non_admin = users(:archer)
  end

  test 'index as admin including pagination and delete link' do
    log_in_as(@admin)
    get users_path
    # I didn't understand what's the purpose of this toggling (reverse the boolean value)
    first_page_of_users = User.paginate(page: 1)
    first_page_of_users.first.toggle!(:activated)
    assert_template 'users/index'
    assert_select 'div.digg_pagination', count: 2
    assigns(:users).each do |user|
      assert user.activated?
      assert_select 'a[href=?]', user_path(user), text: user.name
      unless user == @admin
        assert_select 'a[href=?]', user_path(user), text: 'delete'
      end
    end
    assert_difference 'User.count', -1 do
      delete user_path(@non_admin)
    end
    assert_redirected_to users_path
  end
end