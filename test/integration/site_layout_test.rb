require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end

	test "layout_links" do
#paths test	
	get root_path
	assert_template 'static_pages/home'
	assert_select "a[href=?]", root_path, count: 2
    assert_select "a[href=?]", help_path
    assert_select "a[href=?]", about_path
    assert_select "a[href=?]", contact_path
  #full_title test.there is also a test of full_title functionality in application_helper_test.rb
  	    get help_path
    assert_select "title", full_title("Help")

  end


end
