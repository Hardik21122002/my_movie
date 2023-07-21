class BookingInfo < ApplicationRecord 
  belongs_to :user 
  belongs_to :theater 
  belongs_to :screen 
  belongs_to :show


  before_save :set_remaining_seats 
  validates :no_of_tickets, numericality: { greater_than: 0 }
  
  private
 
  def set_remaining_seats 
    show_time = self.show.show_times.find_by(time: self.booking_time)
    return unless show_time
    
    if self.booking_time.to_date == Date.today
      remaining_seats = show_time.remaining_seats - self.no_of_tickets
      show_time.update_columns(remaining_seats: remaining_seats)
    end
  end
end

