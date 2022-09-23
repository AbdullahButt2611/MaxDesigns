class AmountReceivedsController < ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource

    def index

    end

    def user_amount
        @users_amount_data = AmountReceived.current_users_amounts_added(current_user.id)
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
        received.project.project_details.create(date: Time.now, task: "Amount Received from owner as  " + received.mode + "for the purpose of "+ received.purpose+" and is stored in reference no: "+received.id.to_s, user_id: current_user.id)
    end

    def project_amount_update(project, amount)
        project.update(amount_present: project.amount_present + amount)
    end

end