class AddDurationToShow < ActiveRecord::Migration[6.0]
  def change
    add_column :shows, :duration, :time
  end
end
