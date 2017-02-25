class SessionsController < ApplicationController
  def new
  end
  
  def create
  #match contol from model and session input,hash in sessions are defined as [:sessions][:email]
  #downcase because entries in db are saved as downcase to avoid duplicates
  user = User.find_by(email: params[:session][:email].downcase)
  	if user && user.authenticate(params[:session][:password])
  	# Log the user in and redirect to the user's show page.
  	log_in user
  	redirect_to user
  	else
  	#create an error message
    flash.now[:danger] = 'Invalid email/password combination' # Not quite right!
  	render 'new'
  	end
  end 
  
  def destroy
  	log_out
  	redirect_to root_url
  end
  
  
end