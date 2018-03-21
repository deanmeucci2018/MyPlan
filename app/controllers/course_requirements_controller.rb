class CourseRequirementsController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update, :show, :delete, :enrollment, :interested] #:index may be needed for admin and instead of delete could be destroy
  #before_action :correct_user, only: [:edit, :update, :show] #:index may be needed for admin
  before_action :admin_user,  only:  [:destroy, :index]
  
  def index
    @course_requirements = CourseRequirement.all
  end

  def new
    @course_requirement = Course_requirement.new
  end

  def edit
  end
  

  def show
  end

  def update
    
  end

  def create
     @course_requirement = Course_requirement.new(course_requirement_params)

    respond_to do |format|
      if @course_requirement.save
        format.html { redirect_to @course_requirement, notice: 'Course Requirement was successfully created.' }
        format.json { render :show, status: :created, location: @course_requirement }
      else
        format.html { render :new }
        format.json { render json: @course_requirement.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def destroy
    Course_requirement.find(params[:id]).destroy
	  flash[:success] = "Course Requirement successfully deleted"
	  redirect_to users_path
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_course_requirement
      @course_requirement = Course_requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_requirement_params
      params.require(:course_requirement).permit(:requirement_id, :course_id)
    end
    
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
