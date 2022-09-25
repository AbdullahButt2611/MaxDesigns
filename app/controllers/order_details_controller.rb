class OrderDetailsController < ApplicationController
    before_action :authenticate_user!
	load_and_authorize_resource
    
    def new
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @order_details = @order.order_details
        @vendors = Vendor.all_vendors
        @order_detail = @order.order_details.new
    end
    
    def create
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        @vendor = Vendor.find_by_company_name(@vendor_name)
        @order_detail = @order.order_details.new(quantity: order_detail_params[:quantity], vendor_id: @vendor.id, 
        item_id: order_detail_params[:item_id], order_id: order_detail_params[:order_id])
        if @order_detail.save
            redirect_to project_order_path(@project, @order)
        else
            render layout: false
        end
    end

    def destroy
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
        if @order.order_type == "unpaid"
            @order_detail = @order.order_details.find(params[:id])
            @order_detail.destroy
        end
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
        @vendor_name = params[:order_detail][:vendor_name]
    	params.require(:order_detail).permit(:quantity,:vendor_id, :item_id, :order_id, :project_id)
    end

end