require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest 

	def setup 
 	@user= users(:fixture)
 end	

  test "login with invalid information" do
  	
    #1.Visit the login path.
    #2.Verify that the new sessions form renders properly.
    #3.Post to the sessions path with an invalid params hash.
    #4.Verify that the new sessions form gets re-rendered and that a flash message appears.
    #5.Visit another page (such as the Home page).
    #6.Verify that the flash message doesn’t appear on the new page. 
    
    get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email: "", password: "" } }
    assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end


	test "login with valid information followed by logout" do
    #Visit the login path.
    #Post valid information to the sessions path.
    #Check if logged in
    #Verify that the login link disappears.
    #Verify that a logout link appears
    #Verify that a profile link appears. 
    #logout check-logout_path, not logged in,redirection to root,_header menu change
    get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?
    assert_redirected_to @user
    follow_redirect!
    assert_template 'users/show'
    assert_select "a[href=?]", login_path, count: 0
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
    #logout
    delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
     # Simulate a user clicking logout in a second window.
    delete logout_path
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
    end
  
  	test "login with remembering" do
    log_in_as(@user, remember_me: '1')
    assert_not_empty cookies['remember_token']
    end

  test "login without remembering" do
    # Log in to set the cookie.
    log_in_as(@user, remember_me: '1')
    # Log in again and verify that the cookie is deleted.
    log_in_as(@user, remember_me: '0')
    assert_empty cookies['remember_token']
  end



end
