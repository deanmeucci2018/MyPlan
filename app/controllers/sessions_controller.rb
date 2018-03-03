class SessionsController < ApplicationController
  def new
  end
  
  
  def create
		   user = User.find_by(email: params[:session][:email].downcase) #finds a user with the supplied email
		   if user && user.authenticate(params[:session][:password]) #if the user is authenticated – we used this in part 2 as well
			    log_in user #use the helper to log the user in by saving its id to the session hash
			    redirect_to user #redirects the user’s view (this is the show action/view)
		   else
			    flash.now[:danger] = 'Invalid email/password combination'
			    render 'new' #if authenticate fails, render the new view again so the user can try to login again
		   end
  end

	def destroy
		log_out   #log the user out, this is again defined in the sessionsHelper
		redirect_to '/static_pages/about' #redirect the user to the homepage
	end

  
end
