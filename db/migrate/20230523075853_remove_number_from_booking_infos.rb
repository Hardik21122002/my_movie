class RemoveNumberFromBookingInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :booking_infos, :number, :integer
  end
end
