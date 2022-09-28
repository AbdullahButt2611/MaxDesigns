ActiveAdmin.register Order do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :order_type, :order_date, :project_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:order_type, :order_date, :project_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  scope :unpaid_order
  scope :paid_order

  filter :project
  filter :order_type, as: :select, collection: Order.all.order_types
  filter :order_date

  show do
    # renders app/views/admin/posts/_some_partial.html.erb
    render 'show_partial', { order: order }
  end

  index do
    selectable_column
    id_column
    column :project
    column :order_date
    column "Total Bill" do |order|
      "Rs: "+calculate_total_sum_of_order(order).to_s
    end
    column "Items Count" do |order|
      order.order_details.count.to_s+" Item(s)"
    end
    column :order_type
    actions
  end
  
end
