class AddShowToBookingInfo < ActiveRecord::Migration[6.0]
  def change
    add_reference :booking_infos, :show, foreign_key: true
  end
end
