class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :delete, :enrollment, :interested] #:index may be needed for admin and instead of delete could be destroy
  before_action :correct_user, only: [:edit, :update, :show] #:index may be needed for admin
  before_action :admin_user,  only:  [:destroy, :index]
  
  def index
    @users = User.all
  end
  
  def new
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def enrollment
    @user = User.find(params[:id])
    @previous = ""
    @previoustop = ""
    #ordering sections
    @section_first = Section.joins(:course).order(:section_year, :semester, :course_id)
    @section_order = @section_first.group_by {|t| [t.section_year, t.semester, t.course.department.dep_short_name] }
    
    #@sectionyear = Section.find_by_section_year(params[:section_year])
    #@sectionsemester = Section.find_by_semester(params[:semester])
    
   
      @section = Section.joins(:course).order(:section_year, :semester, :course_id).where("section_year = :section_year AND semester = :semester",{section_year: params[:section_year], semester: params[:semester]})
      @section_time = @section.group_by {|t| [t.section_year, t.semester, t.course.department.dep_short_name] }
    
    #Helper for adding previously selected classes
    @Helper = Section.joins(:course).order(:section_year, :semester, :course_id).where("section_year = :section_year AND semester = :semester",{section_year: params[:section_year], semester: params[:semester]})
  

  end
  

  
  def interested
    @user = User.find(params[:id])
    @interests = Interest.joins(:department).order(:department_id, :interest_type, :interest_name)
    @interest_order = @interests.group_by {|i| [i.department.dep_full_name] }
  end
  
  
  def create
    @user = User.new(user_params)#create a new user object with the parameters sent by the form
     if @user.save
       log_in @user   #this will log the user in right after they signup for an account
       flash[:success] = "Account created successfully!"#if the User object saves successfully 
       redirect_to @user #redirects to the show action – executes the action and renders view
     else 
       flash[:alert] = "Account not created successfully, you need to make sure and follow email and password field rules"
       render 'new' #this will just render the new view if the user is not saved successfully (this usually means that the validations didn’t pass)
     end
  end
  
  def update
   @user = User.find(params[:id]) #this finds the user with the specified id
   #allow blank password for update
   if params[:password].blank?
      params.delete(:password)
   end

    
   @user.total_credits = @user.enrolls.sum{ |p| p.section.course.course_credits}
   
   if @user.update_attributes(user_params)  #if the user’s attributes are updated successfully
	  flash[:success] = "Profile updated"
      redirect_to @user  #redirect the user to the show action/view.
   else
      render 'edit'  #if the edit was unsuccessful, render the edit view again
   end
  end

  
  def destroy #make sure this action is not private!!!!
	  User.find(params[:id]).destroy
	  flash[:success] = "User successfully deleted"
	  redirect_to users_path
  end
  
  
  private #make sure this is in the bottom of the file, if you add any other methods under private, they will be private as well and we won’t have access to them from the web interface. The only method that we want private here is the user_params method. No other methods should be private!!!! 
    def user_params
	    params.require(:user).permit(:student_first_name, :student_last_name, :grad_year, :email, :password, 
      :password_confirmation, :total_credits, section_ids:[], interest_ids:[])
      #:user is the required attribute while name, email, password and password_confirmation are permitted to pass to the create action
      #This method is private because it is only used by the users controller and should not be accessible by anything else. 
    end
    
    def logged_in_user
      if false == logged_in?
         flash[:alert] = "Invalid"
         redirect_to(login_url)
      end
    end
    
    def correct_user
	      @user = User.find(params[:id])
	      redirect_to(root_url) unless current_user?(@user) or current_user.admin? #may need to comment out
        #this action can be private
    end
    
    def admin_user
      if false == logged_in?
         flash[:alert] = "Invalid"
         redirect_to(login_url)
         
      else
          redirect_to(root_url) unless current_user.admin? #this makes sure that if the user is not an admin user, they are redirected to root_url
      end
    end
  
end
