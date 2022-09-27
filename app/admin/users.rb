ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :username, :name, :contact, :qualification, :pay, :activity_status, :user_roles, :avatar
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email, :username, :name, :contact, :qualification, :pay, :activity_status, :user_roles, :avatar]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  scope :developer_users
  scope :customer_users
  scope :accountant_users
  scope :management_users
  scope :hr_users
  scope :architect_users
  scope :pending_users

  filter :name
  filter :email
  filter :username
  filter :contact
  filter :qualification, as: :select, collection: User.all.pluck("qualification").uniq!
  filter :activity_status, as: :select, collection: User.all.activity_statuses
  filter :user_roles, as: :select, collection: User.all.user_roles

  index do
    selectable_column
    column "Image" do |user|
      image_tag(image_url(user.avatar),width:100, height:50)
    end
    id_column
    column :name
    column :email
    column :contact
    column :qualification
    column :activity_status
    column :user_roles
    column :pay
    column "Last Updated", :updated_at
    actions
  end

  show do
    # renders app/views/admin/posts/_some_partial.html.erb
    render 'show_partial', { user: user }
  end

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :qualification
      f.input :contact
      f.input :activity_status
      f.input :user_roles
      f.input :pay
      f.input :avatar
    end
    f.actions
  end

  
end
