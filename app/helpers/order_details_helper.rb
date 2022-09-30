module OrderDetailsHelper

    # This method will return the vendor's data searched by the name of the company
    def find_by_company_name(name)
        vendor = Vendor.find_by_company_name(name)
    end

end