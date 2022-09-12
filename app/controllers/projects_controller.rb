class ProjectsController < ApplicationController
	before_action :authenticate_user!

	def index
		@projects = Project.all
	end

	def new
		@project = Project.new
		@date_now = Date.current
	end

	def create
	    @project = Project.new(project_params)
	    if @project.valid?
		    @project.enqueued!			# To change the status of the project
		end
	    if @project.save
	      redirect_to dashboard_path
	    else
	      render :new
	    end
  	end

  	def edit
		@project = Project.find(params[:id])
	end

	def update
		@project = Project.find(params[:id])

		if @project.update(project_params)
	      redirect_to projects_path
	    else
	      render :edit
	    end
	end

	def destroy
  		@project = Project.find(params[:id])
  		@project.destroy
  		redirect_to projects_path
  	end

  	def show
	    @project = Project.find(params[:id])
	end



  	def project_params
    	params.require(:project).permit(:name,:client_name, :contact, :location, :amount_promised, :deadline, :project_type)
  	end
end