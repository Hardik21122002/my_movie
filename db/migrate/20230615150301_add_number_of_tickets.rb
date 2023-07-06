class AddNumberOfTickets < ActiveRecord::Migration[6.0]
  def change 
    add_column :booking_infos, :no_of_tickets, :integer
  end
end
