require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "invalid signup infomation" do
    get signup_path
    assert_no_difference "User.count" do
      post signup_path, params: { user: { name:"", email:"user@invalid", password:"foo", password_confirmation:"bar" } }
    end
    assert_select 'form[action="/signup"]'
    assert_template 'users/new'
    assert_select 'div#error_explanation'
    assert_select 'div.alert'
    assert_select 'div.alert-danger'
  end

  test "valid signup infomation" do
    get signup_path
    assert_difference "User.count", 1 do
      post signup_path, params: { user: { name: "example user", email: "user@example.com", password:"foobarbaz", password_confirmation:"foobarbaz" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert_not flash.empty?
  end


  # test "the truth" do
  #   assert true
  # end
end
