ActiveAdmin.register ProjectDetail do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
   permit_params :date, :task, :project_id, :order_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:date, :task, :project_id, :order_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :project
  filter :user
  filter :date
  filter :id

  index do
    selectable_column
    id_column
    column :project
    column "Task Performed", :task
    column :order_id
    column "Detail Added By", :user
    column "Email" do |detail|
      User.find(detail.user_id).email
    end
    column :date
    column "Last Updated", :updated_at
    actions
  end
  
end
