class AddScreenIdToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :screen_id, :integer
  end
end
