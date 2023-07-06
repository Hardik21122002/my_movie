class RemoveUserRefFromScreens < ActiveRecord::Migration[6.0]
  def change
    remove_reference :screens, :user, null: false, foreign_key: true
  end
end
