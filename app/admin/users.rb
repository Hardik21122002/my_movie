ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at
  #
  # or
  #
  # permit_params do
  #   permitted = [:email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end 


  permit_params :email, :password, :password_confirmation, :role, :theater_ids

  index do
    selectable_column
    id_column
    column :email
    column :role
    column :created_at 
    column :theater_ids do |u|
      u.theaters
    end
    actions
  end

  filter :email
  filter :role
  

  form do |f|
    f.inputs do
      f.input :email
      f.input :role, as: :select, collection: User.roles.keys 
      f.input :theater_ids, as: :select, collection: Theater.all
    end
    f.actions
  end  
end


