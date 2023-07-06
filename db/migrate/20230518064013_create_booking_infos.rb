class CreateBookingInfos < ActiveRecord::Migration[6.0]
  def change
    create_table :booking_infos do |t|
      t.string :screen_type
      t.integer :number
      t.datetime :booking_date
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
