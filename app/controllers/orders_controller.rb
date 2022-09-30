class OrdersController < ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource
    before_action :get_project_order_data, only: [:destroy, :show]
    before_action :create_init_method, only: :create
    

    



    def create

        if @order.save
            create_project_detail(@order)
            redirect_to project_order_path(project_id: @project.id, id: @order.id)
        else 
            redirect_to dashboard_path
        end

    end


    def destroy
        delete_project_detail(@order)
        @order.destroy
        create_delete_project_detail(@order)
        render layout: false
    end

    
    def show
    end










    # ========================================================================================================================================================
    # ======================================================        Additional Functions        ==============================================================
    # ========================================================================================================================================================
    
    
    private
    
    # This method will create a project detail about the creation of order
    def create_project_detail(order)
        if order.project.enqueued?
            update_project_status(order.project)
        end
        order.project.project_details.create(date: Time.now, task: "A new order has been added with the Order Reference: " + order.id.to_s, user_id: current_user.id, order_id: order.id)
        change_final_status(order.project)
    end



    # If the project details are greater than 45, then it will change the statis to final stage.
    def change_final_status(project)
		if project.project_details.count >= 45
			project.final_stage!
		end
	end



    # If the project hasn't started yet, then it will remove it from 
    # enqueud and will add it to the in_progress list
    def update_project_status(project)
        project.update(project_status: :in_progress)
    end



    # If the order is deleted, then the project details's reference needs to 
    # be removed as the association will be there to corelate
    def delete_project_detail(order)
        detail = ProjectDetail.find_by_order_id(order.id)
        if detail
            detail.update(order_id: nil)
        end
    end

    
    # After deletion of the order, a new detail is added to system regarding the order deletion
    def create_delete_project_detail(order)
        order.project.project_details.create(date: Time.now, task: "An order with the Order Reference: " + order.id.to_s+" has been deleted.", user_id: current_user.id)
        change_final_status(order.project)
    end





    # Method to collect the data
    def get_project_order_data
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:id])
    end


    def create_init_method
        @project = Project.find(params[:project_id])
        @order = @project.orders.new
        @order.order_date = DateTime.now
        @order.unpaid!
    end

    
end