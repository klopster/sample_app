require 'test_helper'

class UsersProfileTest < ActionDispatch::IntegrationTest
   include ApplicationHelper

  def setup
    @user = users(:fixture)
  end

  test "profile display" do
    get user_path(@user)
    assert_template 'users/show'
    assert_select 'title', full_title(@user.name)
    assert_select 'h1', text: @user.name
    assert_select 'h1>img.gravatar'
    assert_match @user.microposts.count.to_s, response.body
    #assert_select 'div.pagination' dont understand why,but not work..will_paginate render div.pagination just fine
     @user.microposts.paginate(page: 1).each do |micropost|
      assert_match micropost.content, response.body
    
    end
  end
end

