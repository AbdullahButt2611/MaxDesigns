ActiveAdmin.register Vendor do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :company_name, :address, :user_id, :company_type
  #
  # or
  #
  # permit_params do
  #   permitted = [:company_name, :address, :user_id, :company_type]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end


  filter :company_name
  filter :address
  filter :created_at
  filter :updated_at
  filter :company_type, as: :select, collection: Vendor.all.company_types
  
  index do
    selectable_column
    id_column
    column :user
    column "Email" do |vendor|
      User.find(vendor.user_id).email
    end
    column :company_name
    column :address
    column :company_type
    column "No. Of Items" do |vendor|
      vendor.items.count
    end
    column "Last Updated", :updated_at
    actions
  end

  show do
    # renders app/views/admin/posts/_some_partial.html.erb
    render 'show_partial', { vendor: vendor }
  end


end
