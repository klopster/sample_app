require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

	def setup
	
	@user = User.new(name: "example_user" , email: "example@net.com" ,
									password: "foobar" , password_confirmation: "foobar" )
	end
	
	test "should be valid" do
	assert @user.valid?
	end
	
	test "name should be present" do
	@user.name = ""
	assert_not @user.valid?
	end
			
	test "email should be present" do
	@user.email = ""
	assert_not @user.valid?
	end
	
	test "username should no be too long" do
	@user.name = "a" * 51
	assert_not @user.valid?
	end
	
	test "email should not be too long" do
	@user.name = "a" * 256
	assert_not @user.valid?
	end
	
	test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end
	
	test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end
	
	test "email should be unique" do
	# make duplicate and save original in db,so then is not unique anymore and test fail
	duplicate_user = @user.dup
	#test for case-insensitivity,because we need really unigue.so for test we shift all in upcase
	duplicate_user.email = @user.email.upcase
	@user.save
	assert_not duplicate_user.valid?
	end
	
	  test "email addresses should be saved as lower-case" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end
  
  test "password should have a minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
  
  test "password should be present (not-blank)" do
  	@user.password = @user.password_confirmation = "" * 6
  	assert_not @user.valid?
  end
  
    test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end
  
  
  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
	end
	
	test "should follow and unfollow a user" do
    fixture = users(:fixture)
    fixture2  = users(:fixture2)
    assert_not fixture.following?(fixture2)
    fixture.follow(fixture2)
    assert fixture.following?(fixture2)
    assert fixture2.followers.include?(fixture)
    fixture.unfollow(fixture2)
    assert_not fixture.following?(fixture2)
  end


	test "feed should have the right posts" do
    michael = users(:fixture)
    archer  = users(:fixture2)
    lana    = users(:fixture3)
    # Posts from followed user
    lana.microposts.each do |post_following|
      assert michael.feed.include?(post_following)
    end
    # Posts from self
    michael.microposts.each do |post_self|
      assert michael.feed.include?(post_self)
    end
    # Posts from unfollowed user
    archer.microposts.each do |post_unfollowed|
      assert_not michael.feed.include?(post_unfollowed)
    end
  end
end
