class AddCompanyTypeToVendors < ActiveRecord::Migration[6.1]
  def change
    add_column :vendors, :company_type, :int
  end
end
