class AddRemainngSeatsWithDefaultValue < ActiveRecord::Migration[6.0]
  def change
    change_column :theaters, :remaining_seats, :integer, :default=> 0
  end
end
