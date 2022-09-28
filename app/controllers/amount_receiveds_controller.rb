class AmountReceivedsController < ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource

    def index

    end

    def user_amount
        @users_amount_data = AmountReceived.current_users_amounts_added(current_user.id)
        respond_to do |format|
            format.html
            format.pdf do
              render pdf: current_user.name+"_generated_amount_receipts", template: "amount_receiveds/user_amount_pdf.html.erb", disposition: 'attachment', layout: 'pdf' 
            end
        end
    end

    def new
        @project = Project.find(params[:project_id])
        @amount_received = @project.amount_receiveds.new
    end

    def create
        @project = Project.find(params[:project_id])
        @amount_received = @project.amount_receiveds.new(amount_received_params)
        @amount_received.user_id = current_user.id
        @amount_received.date = DateTime.now
        if @amount_received.save
          project_amount_update(@project, @amount_received.money_received)
          create_project_detail(@amount_received)
	      redirect_to @project
	    else
            render layout: false 
	    end
    end

    private

    def amount_received_params
        params.require(:amount_received).permit(:money_received, :mode, :date, :project_id, :user_id, :purpose)
    end

    def create_project_detail(received)
        if received.project.enqueued?
            update_project_status(received.project)
        end
        received.project.project_details.create(date: Time.now, task: "Amount Received from owner as  " + received.mode + "for the purpose of "+ received.purpose+" and is stored in reference no: "+received.id.to_s, user_id: current_user.id)
        change_final_status(received.project)
    end

    def project_amount_update(project, amount)
        project.update(amount_present: project.amount_present + amount)
    end

    def change_final_status(project)
		if project.project_details.count >= 45
			project.final_stage!
		end
	end

    def update_project_status(project)
        project.update(project_status: :in_progress)
    end

end