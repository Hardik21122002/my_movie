class RemoveDurationFromShows < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :duration, :string
  end
end
