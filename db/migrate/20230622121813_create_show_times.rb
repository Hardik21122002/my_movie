class CreateShowTimes < ActiveRecord::Migration[6.0]
  def change
    create_table :show_times do |t|
      t.time :time 
      t.references :show, null: false, foreign_key: true

      t.timestamps
    end
  end
end
