class AddStatusToScreens < ActiveRecord::Migration[6.0]
  def change
    add_column :screens, :status, :integer
  end
end
