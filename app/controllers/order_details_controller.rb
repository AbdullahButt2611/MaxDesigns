class OrderDetailsController < ApplicationController
    
    def new
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @order_details = @order.order_details
        @order_detail = @order.order_details.new
    end
    
    def create
        byebug
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @order_detail = @order.order_details.create(order_detail_params)
        if @order_detail.save
            redirect_to @order
        else
            render layout: false
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @order_detail = @order.order_details.find(params[:id])
        @order_detail.destroy
        render layout:false
    end


    def search_item_type
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @order_detail = @order.order_details.new
        @item_type = params[:item_type]
        @items = Item.item_based_on_type(@item_type)
        render layout: false
    end

    private
    def order_detail_params
    	params.require(:order_detail).permit(:quantity,:vendor_id, :item_id, :order_id, :project_id, :item)
  	end

end