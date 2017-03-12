class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  #including sessions helper for having helping methods in all controlleres
  include SessionsHelper
  
  private

    # Confirms a logged-in user is here because method is used for users and microposts controllers
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end
   
end
