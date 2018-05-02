class CoursesController < ApplicationController
  before_action :logged_in_user, only: [:show, :index] #:show only for logged in users
  before_action :set_course, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:destroy, :new, :edit, :update]
  
  # GET /courses
  # GET /courses.json
  def index
    @dep_first = Department.joins(:courses).order(:dep_short_name, :id)
    @dep_order = @dep_first.group_by {|t| [t.dep_short_name.to_s, t.id] }
    @courses = Course.all.order(:department_id, :course_number).where("department_id = :department_id",{department_id: params[:department_id]})
  end

  # GET /courses/1
  # GET /courses/1.json
  def show
  end
  

  # GET /courses/new
  def new
    #allows select dropdown
    @options = {}
    department = Department.all
    if department 
      department.each do |u|
        @options[u.dep_short_name] = u.id
      end
    end
    @course = Course.new
  end

  # GET /courses/1/edit
  def edit
    #allows select dropdown
    @options = {}
    department = Department.all
    if department 
      department.each do |u|
        @options[u.dep_short_name] = u.id
      end
    end
  end

  # POST /courses
  # POST /courses.json
  def create
    @course = Course.new(course_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @course, notice: 'Course was successfully created.' }
        format.json { render :show, status: :created, location: @course }
      else
        format.html { render :new }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /courses/1
  # PATCH/PUT /courses/1.json
  def update
    respond_to do |format|
      if @course.update(course_params)
        format.html { redirect_to @course, notice: 'Course was successfully updated.' }
        format.json { render :show, status: :ok, location: @course }
      else
        format.html { render :edit }
        format.json { render json: @course.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /courses/1
  # DELETE /courses/1.json
  def destroy
    @course.destroy
    respond_to do |format|
      format.html { redirect_to courses_url, notice: 'Course was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_course
      @course = Course.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def course_params
      params.require(:course).permit(:course_number, :course_full_name, :course_description, :course_credits, :q_req, :w_req, :s_req, :ah_req, :l_req, :sm_req, :ss_req, :department_id)
    end
    
    
    def logged_in_user
        if !logged_in?
            flash[:failure] = "You must sign in first."
            redirect_to(login_url)
        end
    end
    
    def admin_user
         if logged_in?
            redirect_to root_url unless current_user.admin?
         elsif
          #flash[:failure] = "Invalid Request"
          redirect_to(root_url)
         end
    end
    
end
