class ItemsController < ApplicationController
	before_action :authenticate_user!
	
	def index
		@items = current_user.vendor.items.all
	end

	def new
		@vendor = Vendor.find(params[:vendor_id])
		@item = @vendor.items.new
	end

	def create
	    @vendor = Vendor.find(params[:vendor_id])
	    byebug
		@item = @vendor.items.create(item_params)
	    if @item.save
	      redirect_to profile_path
	    else
	      render :new
	    end
  	end

  	private
  	def item_params
    params.require(:item).permit(:name, :price, :item_type)
  end
end