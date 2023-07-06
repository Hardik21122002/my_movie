class RemoveScreenIdFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :screen_id, :integer
  end
end
