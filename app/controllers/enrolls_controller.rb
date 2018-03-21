class EnrollsController < ApplicationController
  #before_action :logged_in_user, only: [:edit, :update, :show, :delete, :enrollment, :interested] #:index may be needed for admin and instead of delete could be destroy
  #before_action :correct_user, only: [:edit, :update, :show] #:index may be needed for admin
  before_action :admin_user,  only:  [:destroy, :index]
  
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
    Enroll.find(params[:id]).destroy
	  flash[:success] = "User successfully deleted"
	  redirect_to users_path
  end
  
    private
    # Use callbacks to share common setup or constraints between actions.
    def set_enroll
      @enroll = Enroll.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def enroll_params
      params.require(:section).permit(:user_id, :course_id)
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
