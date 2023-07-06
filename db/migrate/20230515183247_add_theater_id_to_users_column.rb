class AddTheaterIdToUsersColumn < ActiveRecord::Migration[6.0]
  def change 
    add_reference :users, :theater, foreign_key: true
  end
end
