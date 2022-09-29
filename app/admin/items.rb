ActiveAdmin.register Item do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :name, :price, :vendor_id, :item_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:name, :price, :vendor_id, :item_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  actions :index, :show, :destroy

  filter :vendor_id , :as => :select, :collection => Vendor.all.map{|vendor| [vendor.company_name, vendor.id]}
  filter :name
  filter :updated_at
  filter :item_type, as: :select, collection: Item.all.item_types
  
  index do
    selectable_column
    id_column
    column :name
    column :price
    column :item_type
    column "Vendor ID", :vendor_id
    column "Company Name" do |history|
      Vendor.find(history.vendor_id).company_name
    end
    column :updated_at
    actions
  end
end
