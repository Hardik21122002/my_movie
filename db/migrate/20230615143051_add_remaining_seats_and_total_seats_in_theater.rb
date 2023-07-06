class AddRemainingSeatsAndTotalSeatsInTheater < ActiveRecord::Migration[6.0]
  def change
    add_column  :theaters,:total_seats, :integer
    add_column  :theaters,:remaining_seats, :integer
  end
end
