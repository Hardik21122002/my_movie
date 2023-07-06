class AddTheaterId < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :theater_id, :integer
  end
end
