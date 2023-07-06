class CreateTheaterUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :theater_users do |t|
      t.references :user, null: false, foreign_key: true
      t.references :theater, null: false, foreign_key: true

      t.timestamps
    end
  end
end
