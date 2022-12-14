ActiveAdmin.register AdminUser do
  permit_params :email, :password, :password_confirmation, :name

  index do
    selectable_column
    id_column
    column :name
    column :email
    column "Last Updated", :updated_at
    actions
  end

  filter :email
  filter :current_sign_in_at
  filter :sign_in_count
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end

  

end
