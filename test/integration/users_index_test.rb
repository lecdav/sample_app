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
    assert_template 'users/index'
    assert_select 'div.digg_pagination', count: 2
    User.paginate(page: 1).each do |user|
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

  test 'should allow the admin user to destroy another user' do
    
  end
end
 