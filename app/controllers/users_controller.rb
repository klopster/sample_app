class UsersController < ApplicationController
  def signup
  @user=User.new
  end
  
  def show
  @user = User.find(params[:id])
  end
  
  
  def create
  @user = User.new(user_params)
  	if @user.save 
  	#handle succesfull save
  	flash[:succes] = "Welcome in my app"
  	redirect_to @user
  	# synonym of redirect_to user_url(@user)
  	else
  	render 'signup'
  	end
  end
  
  #local method for path the security hole of mass assigment of params
  private
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
end
