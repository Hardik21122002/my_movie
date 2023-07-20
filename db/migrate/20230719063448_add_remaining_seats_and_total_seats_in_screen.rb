class AddRemainingSeatsAndTotalSeatsInScreen < ActiveRecord::Migration[6.0]
  def change 
    add_column  :screens,:total_seats, :integer
  end
end
