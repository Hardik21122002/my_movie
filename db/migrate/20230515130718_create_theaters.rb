class CreateTheaters < ActiveRecord::Migration[6.0]
  def change
    create_table :theaters do |t|
      t.string :name
      t.string :addres

      t.timestamps
    end
  end
end
