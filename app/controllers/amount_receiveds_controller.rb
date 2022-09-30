class AmountReceivedsController < ApplicationController
    before_action :authenticate_user!
    before_action :user_amount_collect_data, only: :user_amount
    before_action :model_collect_data, except: :user_amount
	load_and_authorize_resource


    # This method is used to create the history of the user about the amount details added by the user for a particulat project.
    def user_amount

        respond_to do |format|
            format.html
            format.pdf do
              render pdf: current_user.name+"_generated_amount_receipts", template: "amount_receiveds/user_amount_pdf.html.erb", disposition: 'attachment', layout: 'pdf' 
            end
        end

    end


    def new
        @amount_received = @project.amount_receiveds.new
    end


    def create
        @amount_received = @project.amount_receiveds.new(amount_received_params)
        @amount_received.user_id = current_user.id
        if @amount_received.save
            after_save_operation_or_object @project, @amount_received
	        redirect_to @project
	    else
            render layout: false 
	    end
    end















    
    # ========================================================================================================================================================
    # ======================================================        Additional Functions        ==============================================================
    # ========================================================================================================================================================
    private

    # This method is to access the data from the scope and to use it in the views
    def user_amount_collect_data
        @users_amount_data = AmountReceived.current_users_amounts_added(current_user.id)
    end





    # This method is used to get the project data which will be used to create the amount received data.
    def model_collect_data
        @project = Project.find(params[:project_id])
    end





    #This method is to allow the strong params for this model
    def amount_received_params
        params.require(:amount_received).permit(:money_received, :mode, :date, :project_id, :user_id, :purpose)
    end


        



    #Additional Function Performed by after saving the object
    def after_save_operation_or_object project, amount_received
        project_amount_update(project, amount_received.money_received)
        create_project_detail(amount_received)
    end






    # Creates a project detail about receiving an amount
    def create_project_detail(received)
        if received.project.enqueued?
            update_project_status(received.project)
        end
        received.project.project_details.create(date: Time.now, task: "Amount Received from owner as  " + received.mode + " for the purpose of "+ received.purpose+" and is stored in reference no: "+received.id.to_s, user_id: current_user.id)
        change_final_status(received.project)
    end






    # Add the amount received into the project
    def project_amount_update(project, amount)
        project.update(amount_present: project.amount_present + amount)
    end






    #  Function to change the status of the project depending on the functionalities
    def change_final_status(project)
		if project.project_details.count >= 45
			project.final_stage!
		end
	end


    def update_project_status(project)
        project.update(project_status: :in_progress)
    end

end