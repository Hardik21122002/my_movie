class AddScreenNameToScreen < ActiveRecord::Migration[6.0]
  def change
    add_column :screens, :screen_name, :string
  end
end
