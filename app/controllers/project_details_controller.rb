class ProjectDetailsController <ApplicationController
    def new
        @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.new
    end

    def create
        
	    @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.create(project_detail_params)
        @project_detail.user = current_user
	    if @project_detail.save
            if @project.enqueued?
                byebug
                update_project_status(@project)
            end
	      redirect_to @project
	    else
            render layout: false
            
	    end
  	end

    def edit
        @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.find(params[:id])
    end

    def update
        @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.find(params[:id])
        @project_detail.user = current_user
        if @project_detail.update(project_detail_params)
            
            redirect_to @project
        else
            render :edit
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.find(params[:id])
        @project_detail.destroy
        render layout: false
    end

    private
  	def project_detail_params
        params.require(:project_detail).permit(:task, :date, :project_id)
    end

    def update_project_status(project)
        project.update(project_status: :in_progress)
    end
    
end