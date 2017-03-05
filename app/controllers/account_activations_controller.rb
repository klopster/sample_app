class AccountActivationsController < ApplicationController

def edit
    user = User.find_by(email: params[:email])
    #if user in not activated but is authenticated,then update to activated state
    if user && !user.activated? && user.authenticated?(:activation, params[:id])
      user.update_attribute(:activated,    true)
      user.update_attribute(:activated_at, Time.zone.now.date_time
      log_in user
      flash[:success] = "Account activated!"
      redirect_to user
    else
      flash[:danger] = "Invalid activation link"
      redirect_to root_url
    end
  end
end
