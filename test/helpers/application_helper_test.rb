require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  test "full_title helper" do
   assert_equal full_title , "tutorial"
   assert_equal full_title("Help") , "Help | tutorial"
    
    end
    
end
