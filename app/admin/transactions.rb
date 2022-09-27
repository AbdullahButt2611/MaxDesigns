ActiveAdmin.register Transaction do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :amount_paid, :date, :order_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:amount_paid, :date, :order_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :user_id , :as => :select, :collection => User.all.map{|user| [user.username, user.id]}
  filter :order_id
  filter :date
  
  index do
    selectable_column
    id_column
    column :amount_paid
    column :date
    column "Project Name" do |history|
      Project.find(Order.find(history.order_id).project_id).name
    end
    column :order_id
    column :user_id
    column "User" do |trans|
      User.find(trans.user_id).name
    end
    column "Email" do |trans|
      User.find(trans.user_id).email
    end
    column "Last Updated", :updated_at
    actions
  end



end
