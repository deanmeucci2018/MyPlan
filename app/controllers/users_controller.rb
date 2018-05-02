class UsersController < ApplicationController
  before_action :logged_in_user, only: [:edit, :update, :show, :delete,] #:index may be needed for admin and instead of delete could be destroy
  before_action :correct_user, only: [:edit, :update, :show, :enrollment, :interested, :gameplan] #:index may be needed for admin
  before_action :admin_user,  only:  [:destroy, :index]
  
  def index
    @users = User.all
  end
  
  def gameplan
    @user = User.find(params[:id])
    #@sections_taken = Enroll.joins(:section, :user).where("user_id = :id",{id: params[:id]})
        @sects = @user.enrolls.joins(section: :course)
       
        @test2 = Section.joins(:users, :course).where("(section_year = '2018' AND semester = 'Spring') OR user_id = :id",{id: params[:id]})
        @test3 = Section.joins(:users, :course).where("section_year = '2018' AND semester = 'Spring'").or(Section.joins(:users, :course).where("user_id = :id",{id: params[:id]}))
        
        #WORKING FOR BOTH SEMESTER AND COURSES TAKEN
        @test4 = Section.left_outer_joins(:users, :course).where("user_id = :id",{id: params[:id]}).or(Section.left_outer_joins(:users, :course).where("section_year = '2018' AND semester = 'Spring'"))
        #@test5 = Section.left_outer_joins(:users, :course).where.not("courses.id = user.section.course_id AND user_id = :id", id: params[:id]).or(Section.left_outer_joins(:users, :course).where("section_year = '2018' AND semester = 'Spring'"))
        
        
        #@sections_avail = Section.joins(:course).where("section_year = '2018' AND semester = 'Spring'").where.not("course_id = :course_id", {course_id: find_each(params[@test.course])})
        
        #WORKING FOR GETTING JUST COURSES AVAILABLE
        @test = Section.joins(:users, :course).where("user_id = :id",{id: params[:id]})
        @sections_avail = Section.joins(:course).where("section_year = '2018' AND semester = 'Spring'")
        @testids = @test.pluck(:course_id)
        @test6 = @sections_avail.where.not(course_id: @testids)
        #GET INTERESTS FOR STUDENT
        @userreqs = Interest.joins(:users).where("user_id = :id",{id: params[:id]})
        @userreqsids = @userreqs.pluck(:interest_id)
        #GET REQUIREMTENTS FOR STUDENT
        @userreqs2 = Requirement.where(interest_id: @userreqsids)
        @userreqsids2 = @userreqs2.pluck(:id)
        #GET SECTIONS AVAILABLE FOR REMAINING REQS
        @userreqs3 = CourseRequirement.joins(:course, :requirement).where(requirement_id: @userreqsids2)
        @userreqs3ids = @userreqs3.pluck(:course_id)
        @sects_avail_interests = @sections_avail.where(course_id: @userreqs3ids)
        @final = @sects_avail_interests.where.not(course_id: @testids)
        #@userreqsids2 = @userreqs2.pluck(:courses.ids)
        #@userreqs3 = Course.courserequirement.joins(:requirements).where(requirement_id: @userreqsids2)
        #@sect2 = @sections_avail.joins(:users, :course).where.not("users.id = :id",{id: @user})
        #@sect3 = @sect2.where.not("course_id = :course_id", {course_id: params[:course_id]})
        #@sections_avail = Section.joins(:course).where("section_year = '2018' AND semester = 'Spring'")
        # @sects_can_take = @sects.joins(@sections_avail)
   
        #@test = Section.find_by_sql (["SELECT s.section_letter FROM Section s, Course c WHERE s.course_id = c.id AND s.section_year = '2018' AND s.semester = 'Spring'"])
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
