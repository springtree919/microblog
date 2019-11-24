require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
  
  def setup
    @user = users(:Haruki)
  end
  

  test "should get about" do
    get about_path
    assert_response :success
  end
end
