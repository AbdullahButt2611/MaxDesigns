ActiveAdmin.register Project do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :client_name, :contact, :location, :amount_promised, :deadline, :project_type, :project_status, :name, :amount_present, :avatar
  #
  # or
  #
  # permit_params do
  #   permitted = [:client_name, :contact, :location, :amount_promised, :deadline, :project_type, :project_status, :name, :amount_present, :avatar]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  scope :not_completed_projects
  scope :completed_projects

  filter :name
  filter :client_name
  filter :contact
  filter :deadline
  filter :project_type, as: :select, collection: Project.all.project_types
  filter :project_status, as: :select, collection: Project.all.project_statuses


  index do
    id_column
    selectable_column
    column "Image" do |project|
      if project.avatar?
        image_tag(image_url(project.avatar),width:100, height:50)
      end
    end
    column :name
    column :client_name
    column :contact
    column :location
    column :project_type
    column :project_status
    column :amount_present
    column :amount_promised
    column :deadline
    column "Total Details" do |project|
      project.project_details.count
    end
    column "Total Orders" do |project|
      project.orders.count
    end
    column "Last Updated", :updated_at
    actions
  end

  show do
    # renders app/views/admin/posts/_some_partial.html.erb
    render 'show_partial', { project: project }
  end
end
