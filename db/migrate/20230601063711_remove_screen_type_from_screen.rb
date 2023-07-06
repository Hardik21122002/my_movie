class RemoveScreenTypeFromScreen < ActiveRecord::Migration[6.0]
  def change
    remove_column :screens, :screen_type, :string
  end
end
