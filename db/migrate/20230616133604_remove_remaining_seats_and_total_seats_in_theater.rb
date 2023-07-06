class RemoveRemainingSeatsAndTotalSeatsInTheater < ActiveRecord::Migration[6.0]
  def change 
    remove_column  :theaters,:total_seats, :integer
    remove_column  :theaters,:remaining_seats, :integer
  end
end
