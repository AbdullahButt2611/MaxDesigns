class ItemsController < ApplicationController
	before_action :authenticate_user!
	load_and_authorize_resource
	
	before_action :authenticate_user!
	
	def index
		@vendor = Vendor.find(params[:vendor_id])
		@items = @vendor.items.all
	end

	def new
		@vendor = Vendor.find(params[:vendor_id])
		@item = @vendor.items.new
	end

	def create
	    @vendor = Vendor.find(params[:vendor_id])
		@item = @vendor.items.create(item_params)
	    if @item.save
	      redirect_to vendor_items_path
	    else
	      render :new
	    end
  	end

  	def destroy
  		@vendor = Vendor.find(params[:vendor_id])
  		@item = @vendor.items.find(params[:id])
		  delete_order_detail_having_item(@item)
  		@item.destroy
  		render layout: false
  	end

  	def edit
  		@vendor = Vendor.find(params[:vendor_id])
  		@item = @vendor.items.find(params[:id])
  	end

  	def update
  		@vendor = Vendor.find(params[:vendor_id])
  		@item = @vendor.items.find(params[:id])
		if @item.update(item_params)
	      redirect_to vendor_items_path
	    else
	      render :edit
	    end
  	end

  	private
  	def item_params
		params.require(:item).permit(:name, :price, :item_type)
	end

	def delete_order_detail_having_item(item)
		orders = OrderDetail.where(item_id: item.id)
		orders.each do |detail| 
			detail.order.project.project_details.create(date: Time.now, task: "The item with the name " + item.name+" has been removed by the vendor from the shop called "+item.vendor.company_name.titleize+". So, the it's removed from  the order detail of order reference "+detail.order.id.to_s+" of your project.", user_id: current_user.id)
			detail.destroy
		end

	end
end