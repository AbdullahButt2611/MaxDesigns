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
end