class AddRemainingSeatsInShowTime < ActiveRecord::Migration[6.0]
  def change 
    add_column  :show_times,:remaining_seats, :integer
  end
end
