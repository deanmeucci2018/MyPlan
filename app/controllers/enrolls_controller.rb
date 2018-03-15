class EnrollsController < ApplicationController
  def index
    @enrolls = Enroll.all
  end

  def new
    @enroll = Enroll.new
  end

  def edit
  end
  
  def enrollment
    @user = User.find(params[:id])
  end

  def show
  end

  def update
    
  end

  def create
     @enroll = Enroll.new(enroll_params)

    respond_to do |format|
      if @course.save
        format.html { redirect_to @enroll, notice: 'Enroll was successfully created.' }
        format.json { render :show, status: :created, location: @enroll }
      else
        format.html { render :new }
        format.json { render json: @enroll.errors, status: :unprocessable_entity }
      end
    end
  end
  def destroy
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
