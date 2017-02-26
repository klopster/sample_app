class UsersController < ApplicationController
 #only logged in user can do such thing listened below,test to proof that is made too,its a security hole
 before_action :logged_in_user, only: [:index, :edit, :update]
 before_action :correct_user , only: [:edit, :update]
 

	def index
	@users=User.paginate(page: params[:page])
	end
 
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
  	log_in @user
  	flash[:succes] = "Welcome in my app"
  	redirect_to @user
  	# synonym of redirect_to user_url(@user)
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
    
    	
  
end
