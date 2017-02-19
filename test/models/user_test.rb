require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

	def setup
	
	@user = User.new(name: "example_user" , email: "example@net")
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
	

end
