class ShowTime < ApplicationRecord 
  belongs_to :show    
  validates :time, presence: true   

  after_create :assign_remaining_seats 

  def assign_remaining_seats
    self.update(remaining_seats: self.show.screen.total_seats)
  end 

end


