class CreateScreens < ActiveRecord::Migration[6.0]
  def change
    create_table :screens do |t|
      t.string :screen_type
      t.integer :number
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end 
  end
end
