class CreateShowSlots < ActiveRecord::Migration[6.0]
  def change
    create_table :show_slots do |t|
      t.references :show , foreign_key: true
      t.references :slot, foreign_key: true


      t.timestamps
    end
  end
end


