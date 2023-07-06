class AddTheaterToScreen < ActiveRecord::Migration[6.0]
  def change
    add_reference :screens, :theater, foreign_key: true
  end
end
