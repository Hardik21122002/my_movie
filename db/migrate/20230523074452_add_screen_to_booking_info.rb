class AddScreenToBookingInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :booking_infos, :screen, foreign_key: true
  end
end
