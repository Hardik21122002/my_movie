class RemoveRemainingSeatsAndTotalSeatsInShow < ActiveRecord::Migration[6.0]
  def change 
    remove_column  :shows,:total_seats, :integer
    remove_column  :shows,:remaining_seats, :integer
  end
end
