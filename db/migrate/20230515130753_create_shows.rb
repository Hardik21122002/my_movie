class CreateShows < ActiveRecord::Migration[6.0]
  def change
    create_table :shows do |t|
      t.references :theater, null: false, foreign_key: true
      t.string :name
      t.time :duration

      t.timestamps
    end
  end
end
