class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    # @artists = @user.user_roles.map { |ur| ur.role_id == @artists }
    # @mixer = @user.user_roles.map { |ur| ur.role_id == @mixer }
    # @producer = @user.user_roles.map { |ur| ur.role_id == @producer }
    # @instrumentalist = @user.user_roles.map { |ur| ur.role_id == @instrumentalist }

  end

  # GET /users/1
  # GET /users/1.json
  def show
    # @projects_roles = @user.projects_roles
    @projects = @user.project_roles.map { |pr| pr.projects  }

  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
      @user = User.new(user_params)
      @user.active = true
      @user.start_date = Date.current

  		if @user.save
  			session[:user_id] = @user.id
  			redirect_to home_path, notice: "Thank you for signing up!"
  		else
  			flash[:error] = "This user could not be created."
  			render "new"
  		end
  	end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
      session[:user_id] = nil
      redirect_to home_path, notice: "Logged out!"

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:f_name, :l_name, :email, :username, :active, :phone)
    end

end
