class VendorHistorysController < ApplicationController
  before_action :authenticate_user!
	load_and_authorize_resource

    def index
      @vendor = Vendor.find(params[:id])
      @vendor_history = VendorHistory.particular_vendor_history(@vendor.id)
      @month_count = 13
      respond_to do |format|
        format.html
        format.pdf do
          render pdf: @vendor.company_name+" History ", template: "vendor_historys/index_pdf.html.erb", disposition: 'attachment', layout: 'pdf', page_size: "Letter"  
        end
      end
    end
end