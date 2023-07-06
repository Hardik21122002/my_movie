class AddTheaterToBookingInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :booking_infos, :theater, foreign_key: true
  end
end
