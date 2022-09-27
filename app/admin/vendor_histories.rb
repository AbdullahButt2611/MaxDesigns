ActiveAdmin.register VendorHistory do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :amount, :order_id, :vendor_id, :date
  #
  # or
  #
  # permit_params do
  #   permitted = [:amount, :order_id, :vendor_id, :date]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  filter :vendor_id , :as => :select, :collection => Vendor.all.map{|vendor| [vendor.company_name, vendor.id]}
  filter :date
  

  index do
    selectable_column
    id_column
    column "Vendor ID", :vendor_id
    column "Company Name" do |history|
      Vendor.find(history.vendor_id).company_name
    end
    column "Project Name" do |history|
      Project.find(Order.find(history.order_id).project_id).name
    end
    column :order_id
    column "No of Items" do |history|
      Order.find(history.order_id).order_details.count
    end
    column "Amount" do |history|
      "Rs: "+history.amount.to_s
    end
    column :date
  end
end
