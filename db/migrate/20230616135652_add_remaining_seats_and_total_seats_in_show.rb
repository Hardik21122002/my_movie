class AddRemainingSeatsAndTotalSeatsInShow < ActiveRecord::Migration[6.0]
  def change 
    add_column  :shows,:total_seats, :integer
    add_column  :shows,:remaining_seats, :integer 
    add_column  :shows,:time, :Time
  end
end
