ActiveAdmin.register Show do
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :name, :duration, :start_date, :recurring, :end_date, :theater_id, :screen_id, show_times_attributes: [:id, :time]

  #
  # or
  #
  # permit_params do
  #   permitted = [:theater_id, :name, :duration]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  index do
    selectable_column
    id_column
    column :theater_id do |u|
      u.screen.theater
    end
    column :screen_id do |u|
      u.screen.screen_name
    end
    column :name
    column :duration do |u|
      u.duration.strftime('%H hours %M minutes')
    end
    column :start_date 
    column :time do |u|
      u.show_times.map{|x| [x.time.strftime('%I:%M %p')]}
    end
    column :recurring 
    column :end_date 
    actions
  end 

  filter :name 
  filter :duration
  filter :recurring
  
  form do |f|
    f.inputs 'Show Details' do
      f.input :theater_id, as: :select, collection: Theater.all, input_html: { id: 'theater' }
      f.input :screen_id, as: :select, collection: Screen.all.map{|x| [x.screen_name, x.id]}, input_html: { id: 'screens'} 
      f.input :name   
      f.input :duration  
      f.input :start_date, as: :datepicker 
      f.input :recurring, as: :boolean
      if f.object.recurring?
        f.input :end_date, as: :datepicker
      end
    end 
    f.has_many :show_times do |c|
      c.input :time 
    end
    f.actions
  end
end
