class RemoveStatusFromShow < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :status, :integer
  end
end
