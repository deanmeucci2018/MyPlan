class InterestsController < ApplicationController
  before_action :logged_in_user, only: [:show, :index] #:show only for logged in users
  before_action :set_interest, only: [:show, :edit, :update, :destroy]
  before_action :admin_user, only: [:destroy, :new, :edit, :update]
  
  
  # GET /interests
  # GET /interests.json
  def index
    @int_first = Interest.joins(:department).order(:interest_type, :id)
    @int_order = @int_first.group_by {|t| [t.interest_type.to_s, t.id] }
    @interests = Interest.all.order(:department_id, :interest_type).where("interest_type = :interest_type",{interest_type: params[:interest_type]})
  end

  # GET /interests/1
  # GET /interests/1.json
  def show
    @interests_belonging = Requirement.joins(:interest).where("interest_id = ?", params[:id])
    @test = Section.joins(:users, :course).where("user_id = :id",{id: @current_user})
    @testids = @test.pluck(:course_id)
  end

  # GET /interests/new
  def new
    #allows select dropdown
    @options = {}
    department = Department.all
    if department 
      department.each do |u|
        @options[u.dep_short_name] = u.id
      end
    end
    
    @interest = Interest.new
  end

  # GET /interests/1/edit
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

  # POST /interests
  # POST /interests.json
  def create
    @interest = Interest.new(interest_params)

    respond_to do |format|
      if @interest.save
        format.html { redirect_to @interest, notice: 'Interest was successfully created.' }
        format.json { render :show, status: :created, location: @interest }
      else
        format.html { render :new }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /interests/1
  # PATCH/PUT /interests/1.json
  def update
    respond_to do |format|
      if @interest.update(interest_params)
        format.html { redirect_to @interest, notice: 'Interest was successfully updated.' }
        format.json { render :show, status: :ok, location: @interest }
      else
        format.html { render :edit }
        format.json { render json: @interest.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /interests/1
  # DELETE /interests/1.json
  def destroy
    @interest.destroy
    respond_to do |format|
      format.html { redirect_to interests_url, notice: 'Interest was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_interest
      @interest = Interest.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def interest_params
      params.require(:interest).permit(:interest_name, :interest_type, :total_credits_needed, :department_id, :description)
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
