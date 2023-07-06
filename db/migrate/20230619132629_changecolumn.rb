class Changecolumn < ActiveRecord::Migration[6.0]
  def change 
    change_column :booking_infos, :booking_date, :date 
    add_column :booking_infos, :booking_time, :time
  end
end
