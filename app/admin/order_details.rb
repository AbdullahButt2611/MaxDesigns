ActiveAdmin.register OrderDetail do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :quantity, :order_id, :vendor_id, :item_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:quantity, :order_id, :vendor_id, :item_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :order_id , :as => :select, :collection => Order.all.order("id ASC").map{|order| [order.id, order.id]}
  filter :quantity
  filter :vendor_id , :as => :select, :collection => Vendor.all.map{|vendor| [vendor.company_name, vendor.id]}
  filter :item_id , :as => :select, :collection => Item.all.map{|item| [item.name, item.id]}

  index do
    selectable_column
    id_column
    column "Project Name" do |detail|
      Project.find(Order.find(detail.order_id).project_id).name
    end
    column :order_id
    column "Vendor" do |detail|
      Vendor.find(detail.vendor_id).company_name
    end
    column "Item" do |detail|
      Item.find(detail.item_id).name
    end
    column "Item Price" do |detail|
      "Rs: "+Item.find(detail.item_id).price.to_s
    end
    column :quantity
    column "Total Sum" do |detail|
      "Rs: "+(Item.find(detail.item_id).price * detail.quantity).to_s
    end
    column "Last Updated", :updated_at
    actions
  end
  
end
