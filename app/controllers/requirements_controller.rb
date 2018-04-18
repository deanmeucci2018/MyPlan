class RequirementsController < ApplicationController
  before_action :set_requirement, only: [:show, :edit, :update, :destroy]
 #before_action :logged_in_user, only: [:new, :edit, :update]
  before_action :admin_user, only: [:show, :index, :destroy, :new, :edit, :update]
  # GET /requirements
  # GET /requirements.json
  def index
    @requirements = Requirement.all.order(:requirement_name)
  end

  # GET /requirements/1
  # GET /requirements/1.json
  def show
  end

  # GET /requirements/new
  def new
    
    #allows select dropdown
    @options = {}
    interest = Interest.all
    if interest 
      interest.each do |u|
        @options[u.interest_name + ' ' + u.interest_type] = u.id
      end
    end
        #Creation of Table by Department for course selection
    @courses = Course.joins(:department).order(:course_number)
    @course_group = @courses.group_by{ |c| [c.department.dep_short_name]}
    
    @requirement = Requirement.new
  end

  # GET /requirements/1/edit
  def edit
    #allows select dropdown
    @options = {}
    interest = Interest.all
    if interest 
      interest.each do |u|
        @options[u.interest_name+ ' ' + u.interest_type] = u.id
      end
    end
    #Creation of Table by Department for course selection
    @courses = Course.joins(:department).order(:course_number)
    @course_group = @courses.group_by{ |c| [c.department.dep_short_name]}
    
  end

  # POST /requirements
  # POST /requirements.json
  def create
    @requirement = Requirement.new(requirement_params)

    respond_to do |format|
      if @requirement.save
        format.html { redirect_to @requirement, notice: 'Requirement was successfully created.' }
        format.json { render :show, status: :created, location: @requirement }
      else
        format.html { render :new }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /requirements/1
  # PATCH/PUT /requirements/1.json
  def update
    respond_to do |format|
      if @requirement.update(requirement_params)
        format.html { redirect_to @requirement, notice: 'Requirement was successfully updated.' }
        format.json { render :show, status: :ok, location: @requirement }
      else
        format.html { render :edit }
        format.json { render json: @requirement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /requirements/1
  # DELETE /requirements/1.json
  def destroy
    @requirement.destroy
    respond_to do |format|
      format.html { redirect_to requirements_url, notice: 'Requirement was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_requirement
      @requirement = Requirement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def requirement_params
      params.require(:requirement).permit(:requirement_name, :requirement_type, :courses_towards_requirement, :interest_id, course_ids:[])
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
