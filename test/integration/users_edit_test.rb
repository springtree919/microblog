require 'test_helper'

class UsersEditTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:Haruki)
    @other = users(:Misato)
  end
  
  test "unsuccessful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template "users/edit"
    patch user_path, params: {user: {name: "",
                           email: "users@invalid",
                           password: "password",
                           password_confirmation: "password" }}
    assert_template "users/edit"
  end
  
  test "successful edit" do
    log_in_as @user
    get edit_user_path(@user)
    assert_template "users/edit"
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: {user: { name: name,
                                      email: email,
                                      password: "",
                                      password_confirmation: ""}}
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name, @user.name
    assert_equal email, @user.email
  end
  
  test "should redirect edit when not logged in" do
    get edit_user_path @user 
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "should redirect update when not logged in" do
    patch user_path(@user), params: {user: { name: @user.name,
                                             email: @user.email}}
    assert_not flash.empty?
    assert_redirected_to root_url
  end
  
  test "shouled redirect edit when login as wrong user" do
    log_in_as(@other)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "shouled redirect update when login as wrong user" do
    log_in_as(@other)
    patch user_path(@user), params: {user: { name: @user.name,
                                              email: @user.email}}
    assert flash.empty?
    assert_redirected_to root_url
  end
  
  test "successful edit with friendly forwarding" do
    get edit_user_path @user
    log_in_as @user
    assert_redirected_to edit_user_path @user
    name  = "Foo Bar"
    email = "foo@bar.com"
    patch user_path(@user), params: { user: { name:  name,
                                              email: email,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal name,  @user.name
    assert_equal email, @user.email
  end
end
