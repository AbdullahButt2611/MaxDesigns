class OrdersController < ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource
    
    def index
        @all_projects = Project.not_completed_projects
    end
    
    def create 
        @project = Project.find(params[:project_id])
        @order = @project.orders.new
        @order.order_date = DateTime.now
        @order.unpaid!
        if @order.save
            create_project_detail(@order)
            redirect_to project_order_path(project_id: @project.id, id: @order.id)
        else 
            redirect_to dashboard_path
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:id])
        @order.destroy
        render layout: false
    end

    def show
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:id])
    end

    private
    def create_project_detail(order)
        if order.project.enqueued?
            update_project_status(order.project)
        end
        order.project.project_details.create(date: Time.now, task: "A new order has been added with the Order Reference: " + order.id.to_s, user_id: current_user.id, order_id: order.id)
        change_final_status(order.project)
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