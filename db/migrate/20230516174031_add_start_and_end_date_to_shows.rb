class AddStartAndEndDateToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :start_date, :date
    add_column :shows, :end_date, :date
  end
end
