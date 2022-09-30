class OrderDetailsController < ApplicationController
    before_action :authenticate_user!
    before_action :data_collect_method
	load_and_authorize_resource
    
    def new
        @order_details = @order.order_details
        @vendors = Vendor.all_vendors
        @order_detail = @order.order_details.new
    end
    
    def create
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
        if @order.order_type == "unpaid"
            @order_detail = @order.order_details.find(params[:id])
            @order_detail.destroy
        end
        render layout:false
    end


    def search_item_type
        @order_detail = @order.order_details.new
        @item_type = params[:item_type]
        @items = Item.item_based_on_type(@item_type)
        render layout: false
    end




    # ========================================================================================================================================================
    # ======================================================        Additional Functions        ==============================================================
    # ========================================================================================================================================================
    
    private
    
    # Function to allow the strong params
    def order_detail_params
        @vendor_name = params[:order_detail][:vendor_name]
    	params.require(:order_detail).permit(:quantity,:vendor_id, :item_id, :order_id, :project_id)
    end


    # Data Collecting Methods
    def data_collect_method
        @project = Project.find(params[:project_id])
        @order = @project.orders.find(params[:order_id])
    end

end