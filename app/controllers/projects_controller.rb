class ProjectsController < ApplicationController
	before_action :set_project, only: [:show, :edit, :update, :destroy]

	def index
		@active_projects = Project.active.alphabetical.paginate(:page => params[:page]).per_page(10)
		@completed_projects = Project.completed.alphabetical.paginate(:page => params[:page]).per_page(10)
	end

	def show
	end

	def new
		@project = Project.new
	end

	def edit
	end

	def create
		@project = Project.new(project_params)
		@project.owner_id = current_user.id
		if @project.save
			flash[:notice] = "#{@project.title} has been created."
			redirect_to @project
		else
			render :action => 'new'
		end
	end

	def update
		if @project.update(project_params)
			flash[:notice] = "#{@project.title} has been updated."
			redirect_to @project
		else
			render :action => 'edit'
		end
	end

	def destroy
		@project.destroy
		flash[:notice] = "Successfully removed #{@project.title} from Projects."
		redirect_to projects_url
	end

	private

	def set_project
		@project = Project.find(params[:id])
	end

	def project_params
		params.require(:project).permit(:title, :category, :genre, :status, :preview_level, :start_date)
	end
end