require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:Haruki)
  end
  
  test "should get home" do
    log_in_as @user
    get root_path
    assert_response :success
  end

  test "should get about" do
    get about_path
    assert_response :success
  end

  test "should get contact" do
    get contact_path
    assert_response :success
  end
  

end
