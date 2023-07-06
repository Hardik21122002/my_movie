class RemoveNullFalse < ActiveRecord::Migration[6.0]
  def change
    remove_column :shows, :theater_id, :integer
    remove_column :reviews, :theater_id, :integer

    add_column :shows, :theater_id, :integer
    add_column :reviews, :theater_id, :integer
  end
end
