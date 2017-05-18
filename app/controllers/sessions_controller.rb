class SessionsController < ApplicationController
	def create
		auth = request.env["omniauth.auth"]
		user = User.create_or_update_with_omniauth(auth)
		session[:user_id] = user.id
		# redirect_to repositories_path, :notice => "Signed in!"
    redirect_to root_path
	end

  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
