class OrdersController < ApplicationController
    
    def index
        @all_projects = Project.not_completed_projects
    end
    
    def create 
        @project = Project.find(param[:project_id])
        @order = @project.orders.new
        @order.order_date = DateTime.now
        @order.unpaid!
        if @order.saved 
            redirect_to @order
        else 
            redirect_to dashboard_path
        end
    end

    def show
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:id])
    end
end