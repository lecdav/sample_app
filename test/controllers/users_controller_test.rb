require "test_helper"

class UserControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get signup_path
    assert_response :success
    #assert_select "title", "Sign up #{base_title}"
  end
end
