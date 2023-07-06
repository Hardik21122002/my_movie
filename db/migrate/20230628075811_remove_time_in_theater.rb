class RemoveTimeInTheater < ActiveRecord::Migration[6.0]
  def change 
    remove_column :shows, :time, :time
  end
end
