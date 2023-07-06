class AddScreenToShow < ActiveRecord::Migration[6.0]
  def change
    add_reference :shows, :screen, foreign_key: true
  end
end
