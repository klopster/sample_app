class UsersController < ApplicationController
 #only logged in user can do such thing listened below,test to proof that is made too,its a security hole
 before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
 before_action :correct_user , only: [:edit, :update]
 before_action :admin_user , only: [:destroy]
 

	#display list of users and paginate
	def index
	#display only activated users
	@users=User.where(activated: true).paginate(page: params[:page])
	end
 
  def signup
  @user=User.new
  end
  
  #show selected user profile
  def show
  @user = User.find(params[:id])
  redirect_to root_url and return unless @user.activated?
  end
  
  
  def create
  @user = User.new(user_params)
  	if @user.save 
			@user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
	
  	else
  	render 'signup'
  	end
  end
  
  #edit user profile
  def edit
    @user = User.find(params[:id])
  end
  
  #update user profile with recieved params
  def update
  	@user = User.find(params[:id])
  	if @user.update_attributes(user_params)
  	#handle a succesful update
  	flash[:success] = "Profil updated"
  	redirect_to @user
  	
  	else
  	render 'edit'
  	end
  end	
  
  
  #delete user fro users
  def destroy
  	User.find(params[:id]).destroy
  	flash[:success] = "User deleted"
  	redirect_to users_url
  end	
  
    
  #local method for path the security hole of mass assigment of params
  private
  
  def user_params
  params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
  
  #before filters
  def logged_in_user
  	unless logged_in?
  	store_location
  	flash[:danger] = "Please log in first"
  	redirect_to login_url
    end
  end
  
  # Confirms the correct user.
    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_url) unless current_user?(@user)
          
    end
    
    # Confirms an admin user.
    def admin_user
      redirect_to(root_url) unless current_user.admin?
    end
    
    	
  
end
