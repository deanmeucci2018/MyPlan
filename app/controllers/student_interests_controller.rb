class StudentInterestsController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update, :show, :delete, :enrollment, :interested] #:index may be needed for admin and instead of delete could be destroy
  #before_action :correct_user, only: [:edit, :update, :show] #:index may be needed for admin
  before_action :admin_user,  only:  [ :index]
  
  def index
    @student_interests = StudentInterest.all
  end
  
  private
    
    # Only allows admin CRUD   
    def logged_in_user
        if !logged_in?
            flash[:failure] = "You must sign in first."
            redirect_to(login_url)
        end
    end
    
    # Only allows admin CRUD       
    def admin_user
         if logged_in?
            redirect_to root_url unless current_user.admin?
         elsif
          #flash[:failure] = "Invalid Request"
          redirect_to(root_url)
         end
    end
  
end
