require "test_helper"

class HomeTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

  test "home links" do
    get root_path
    assert_select "a[href=?]", signup_path
  end
end
