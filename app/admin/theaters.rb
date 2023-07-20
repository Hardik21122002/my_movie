ActiveAdmin.register Theater do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :addres,:user_ids, users_attributes: [:id, :email, :password ,:password_confirmation, :role], screens_attributes: [:id, :screen_name, :status]
  # or
  #
  # permit_params do
  #   permitted = [:name, :addres]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :name
    column :addres 
    actions
  end

  filter :name 
  filter :addres
 
  form do |f|
    f.inputs do
      f.input :name
      f.input :addres   
      f.input :user_ids, as: :select, collection: User.all.map{|x| [x.email, x.id]}, input_html: { id: 'user-ids-select' }
    end  
    
    f.has_many :users do |a| 
      a.input :email
    # a.input :role, as: :select, collection: User.roles.keys  
      a.input :role, as: :string, input_html: {value: "theater_admin", readonly: true}  
    end    
  
    f.has_many :screens do |c|  
      c.input :screen_name
      c.input :status 
    end
    f.actions 
  end

end

