require 'test_helper'

class FollowingTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:Haruki)
    log_in_as(@user)
    @other = users(:Taichi)
    ActionMailer::Base.deliveries.clear
  end

  test "following page" do
    get following_user_path(@user)
    assert_not @user.following.empty?
    assert_match @user.following.count.to_s, response.body
    @user.following.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end

  test "followers page" do
    get followers_user_path(@user)
    assert_not @user.followers.empty?
    assert_match @user.followers.count.to_s, response.body
    @user.followers.each do |user|
      assert_select "a[href=?]", user_path(user)
    end
  end
  
   test "should follow a user the standard way" do
    assert_difference '@user.following.count', 1 do
      post relationships_path, params: { followed_id: @other.id }
    end
  end

  test "should unfollow a user the standard way" do
    @user.follow(@other)
    relationship = @user.active_relationships.find_by(followed_id: @other.id)
    assert_difference '@user.following.count', -1 do
      delete relationship_path(relationship)
    end
  end
  
  test "should send notofication email" do
    post relationships_path, params: {followed_id: @other.id}
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
  
  test "should not send notification email" do
    post relationships_path, params: {followed_id: @user.id}
    assert_equal 0, ActionMailer::Base.deliveries.size
  end
end