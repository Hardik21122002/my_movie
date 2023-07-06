class RemoveScreenTypeFromBookingInfos < ActiveRecord::Migration[6.0]
  def change
    remove_column :booking_infos, :screen_type, :string
  end
end
