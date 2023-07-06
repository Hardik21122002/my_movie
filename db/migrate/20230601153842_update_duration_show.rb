class UpdateDurationShow < ActiveRecord::Migration[6.0]
  def change
    change_column :shows, :duration, :Time
  end
end
