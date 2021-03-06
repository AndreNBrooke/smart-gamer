class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create

  def create
    @user = User.from_omniauth(request.env['omniauth.auth'])
    @user.email = params[:user][:email] if params[:user]
    if !@user.save
      flash[:error] = "Login Fail" 
      redirect_to root_path
    elsif @user.email == "example@na.com"
      @user.commendations.create(name: "Friendly")
      @user.commendations.create(name: "Teamwork")
      @user.commendations.create(name: "Tilt-Proof")
      sign_in(@user)
    	flash[:notice] = "Add your email please"
    	redirect_to edit_user_path(@user.id)
    else
      sign_in(@user)
      flash[:success] = "Welcome, #{@user.nickname}!"
      redirect_to user_path(@user)
    end
  end

  def destroy
	  if current_user
	    sign_out
	    flash[:success] = "Goodbye!"
	  end
	  	redirect_to root_path
	end


end
