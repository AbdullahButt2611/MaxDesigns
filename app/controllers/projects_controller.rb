class ProjectsController < ApplicationController
	before_action :authenticate_user!

	def index
		@projects = Project.not_completed_projects
	end
	
	def new
		@project = Project.new
		@date_now = Date.current
	end
	
	def create
	    @project = Project.new(project_params)
		@project.amount_present = 0
	    if @project.valid?
		    @project.enqueued!			# To change the status of the project
		end
	    if @project.save
			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	
	def edit
		@project = Project.find(params[:id])
	end
	
	def update
		@project = Project.find(params[:id])

		if @project.update(project_params)
			redirect_to project_path(@project)
	    else
			render layout: false
	    end
	end
	
	def destroy
		@project = Project.find(params[:id])
		@project.destroy
		if params[:redirect]
			redirect_to projects_path
		else
			render layout: false
		end
  	end

  	def show
	    @project = Project.find(params[:id])
		@users_amount_data = AmountReceived.projects_users_amounts_added(current_user.id, @project.id)
	end



  	def project_params
    	params.require(:project).permit(:name,:client_name, :contact, :location, :amount_promised, :deadline, :project_type)
  	end
end