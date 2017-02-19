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
  #full_title test
  	    get contact_path
    assert_select "title", full_title("Contact")

  end


end
