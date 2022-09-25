module OrderDetailsHelper
    def find_by_company_name(name)
        vendor = Vendor.find_by_company_name(name)
    end
end