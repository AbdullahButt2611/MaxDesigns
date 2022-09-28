ActiveAdmin.register AmountReceived do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :money_received, :mode, :purpose, :date, :project_id, :user_id
  #
  # or
  #
  # permit_params do
  #   permitted = [:money_received, :mode, :purpose, :date, :project_id, :user_id]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  filter :project_id , :as => :select, :collection => Project.all.map{|project| [project.name, project.id]}
  filter :mode, as: :select, collection: AmountReceived.all.modes
  filter :date
  filter :user_id , :as => :select, :collection => User.all.map{|user| [user.name, user.id]}
  
  index do
    selectable_column
    id_column
    column :project
    column :money_received
    column :mode
    column :purpose
    column "Received By" do |received|
     User.find(received.user_id).name
    end
    column "Role" do |received|
     User.find(received.user_id).user_roles
    end
    column :date
    actions
  end
  
end
