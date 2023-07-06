class RemoveNumberFromScreen < ActiveRecord::Migration[6.0]
  def change
    remove_column :screens, :number, :integer
  end
end
