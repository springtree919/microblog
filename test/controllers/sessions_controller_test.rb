require 'test_helper'

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get root_path
    assert_response :success
  end
  
  test "should not get new when logged in" do
    @user = users(:Haruki)
    log_in_as @user
    get root_path
    assert_redirected_to home_url
  end
end
