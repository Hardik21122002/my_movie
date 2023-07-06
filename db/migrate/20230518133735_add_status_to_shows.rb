class AddStatusToShows < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :status, :integer
  end
end
