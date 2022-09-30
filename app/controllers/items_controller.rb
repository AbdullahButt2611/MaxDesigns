class ItemsController < ApplicationController
	before_action :authenticate_user!
	before_action :data_collect_method
	before_action :particular_item_data_collect_method, only: [:destroy, :edit, :update] 
	before_action :all_item_data_collect_method, only: [:index] 
	load_and_authorize_resource
	
	def index
	end

	def new
		@item = @vendor.items.new
	end

	def create
		@item = @vendor.items.create(item_params)
	    if @item.save
	      redirect_to vendor_items_path
	    else
	      render layout: false
	    end
  	end

  	def destroy
		delete_order_detail_having_item(@item)
  		@item.destroy
  		render layout: false
  	end

  	def edit
  	end

  	def update
		if @item.update(item_params)
	      redirect_to vendor_items_path
	    else
			render layout: false
	    end
  	end









	# ===============================================================================================================================
	# ==================================      Additional Functions Defined      =====================================================
	# ===============================================================================================================================

  	private

	# Method to allow strong params
  	def item_params
		params.require(:item).permit(:name, :price, :item_type)
	end




	# A method used to delete the order-details and is called before deleting 
	# the item, so that the association is not disturbed.
	def delete_order_detail_having_item(item)
		orders = OrderDetail.where(item_id: item.id)
		orders.each do |detail| 
			detail.order.project.project_details.create(date: Time.now, task: "The item with the name " + item.name+" has been removed by the vendor from the shop called "+item.vendor.company_name.titleize+". So, the it's removed from  the order detail of order reference "+detail.order.id.to_s+" of your project.", user_id: current_user.id)
			detail.destroy
		end

	end



	# Data Collecting Methods
	def data_collect_method
		@vendor = Vendor.find(params[:vendor_id])
	end

	def particular_item_data_collect_method
		@item = @vendor.items.find(params[:id])
	end
	
	def all_item_data_collect_method
		@items = @vendor.items.all
	end

end