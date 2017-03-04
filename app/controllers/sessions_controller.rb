class SessionsController < ApplicationController
  def new
  
  end
  
  def create
  #match control from model and session input,hash in sessions are defined as [:sessions][:email]
  #downcase because entries in db are saved as downcase to avoid duplicates
  user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	# Log the user in and redirect to the user's show page.
  	log_in user
  	
  	#ternary operator reduce code size...means:if params==1 remember(user) else forget(user)
  	params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  	redirect_back_or user
  	else
  	#create an error message
    flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
  	render 'new'
  	end
  end 
  
  def destroy
  	log_out if logged_in?
  	redirect_to root_url
  end
  
  
end
