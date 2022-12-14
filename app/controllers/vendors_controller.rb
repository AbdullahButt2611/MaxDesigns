class VendorsController < ApplicationController
	before_action :authenticate_user!
	
	def new
		authorize! :new, current_user
		@vendor = Vendor.new
	end

	def create
	    @vendor = Vendor.new(vendor_params)
	    if @vendor.save
	      redirect_to profile_path
	    else
	      render layout: false
	    end
  end

	def edit
		@vendor = current_user.vendor
	end

	def update
		@vendor = current_user.vendor

		if @vendor.update(vendor_params)
	      redirect_to profile_path
	    else
			render layout: false
	    end
	end

	def item_details_page
		@vendors = Vendor.total_vendors_objects
	end

  private

  def vendor_params
    params.require(:vendor).permit(:company_name, :user_id, :address)
  end
end