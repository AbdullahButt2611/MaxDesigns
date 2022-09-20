class OrdersController < ApplicationController
    
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

    def show
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:id])
    end

    private
    def create_project_detail(order)
        order.project.project_details.create(date: Time.now, task: "A new project has been created", user_id: current_user.id)
    end

    
end