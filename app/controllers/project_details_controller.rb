class ProjectDetailsController <ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource
    before_action :project_project_detail_data_collect, only: [:edit, :update, :destroy]
    before_action :project_data_collect, only: [:new, :create]
    




    def new
        @project_detail = @project.project_details.new
    end

    def create
        @project_detail = @project.project_details.new(project_detail_params)
        @project_detail.user = current_user
	    if @project_detail.save
            
	        redirect_to @project
	    else
            render layout: false
	    end
  	end

    def edit
    end

    def update
        @project_detail.user = current_user
        if @project_detail.update(project_detail_params)
            redirect_to @project
        else
            render layout: false
        end
    end

    def destroy
        @project_detail.destroy
        render layout: false
    end









    # ========================================================================================================================================================
    # ======================================================        Additional Functions        ==============================================================
    # ========================================================================================================================================================
    private

    # Method to allow the strong params
  	def project_detail_params
        params.require(:project_detail).permit(:task, :date, :project_id)
    end



    #  Method to update the project status depending on the project details added
    def update_project_status(project)
        if project.enqueued?
            project.update(project_status: :in_progress)
        else 
            change_final_status(project)
        end
    end


    #   Method to set the status to final staged project if project details exceed the count of 45
    def change_final_status(project)
		if project.project_details.count >= 45
			project.final_stage!
		end
	end





    # Data Collection Method
    def project_project_detail_data_collect
        @project = Project.find(params[:project_id])
        @project_detail = @project.project_details.find(params[:id])
    end

    def project_data_collect
        @project = Project.find(params[:project_id])
    end
    


    
end