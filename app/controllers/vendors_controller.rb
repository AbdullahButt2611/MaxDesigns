class VendorsController < ApplicationController
	before_action :authenticate_user!
	
	def new
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

  private

  def vendor_params
    params.require(:vendor).permit(:company_name, :user_id, :address)
  end
end