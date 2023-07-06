class RemoveTheaterIdFromUser < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :theater_id, :integer
  end
end
