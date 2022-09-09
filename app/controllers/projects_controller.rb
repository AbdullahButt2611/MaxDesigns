class ProjectsController < ApplicationController
	before_action :authenticate_user!

	def index
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




  	def project_params
    	params.require(:project).permit(:name,:client_name, :contact, :location, :amount_promised, :deadline, :project_type)
  	end
end