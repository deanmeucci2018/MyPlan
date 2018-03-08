class SectionsController < ApplicationController
  before_action :set_section, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:show, :index, :destroy, :new, :edit, :update]

  # GET /sections
  # GET /sections.json
  def index
    @sections = Section.all
  end

  # GET /sections/1
  # GET /sections/1.json
  def show
  end

  # GET /sections/new
  def new
    #allows select dropdown
    @options = {}
    course = Course.all
    if course 
      course.each do |u|
        @options[u.course_full_name] = u.id
      end
    end
    
    @section = Section.new
  end

  # GET /sections/1/edit
  def edit
    #allows select dropdown
    @options = {}
    course = Course.all
    if course 
      course.each do |u|
        @options[u.course_full_name] = u.id
      end
    end
  end

  # POST /sections
  # POST /sections.json
  def create
    @section = Section.new(section_params)

    respond_to do |format|
      if @section.save
        format.html { redirect_to @section, notice: 'Section was successfully created.' }
        format.json { render :show, status: :created, location: @section }
      else
        format.html { render :new }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /sections/1
  # PATCH/PUT /sections/1.json
  def update
    respond_to do |format|
      if @section.update(section_params)
        format.html { redirect_to @section, notice: 'Section was successfully updated.' }
        format.json { render :show, status: :ok, location: @section }
      else
        format.html { render :edit }
        format.json { render json: @section.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /sections/1
  # DELETE /sections/1.json
  def destroy
    @section.destroy
    respond_to do |format|
      format.html { redirect_to sections_url, notice: 'Section was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_section
      @section = Section.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def section_params
      params.require(:section).permit(:start_time, :end_time, :professor, :section_letter, :semester, :section_year, :section_days, :course_id)
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
