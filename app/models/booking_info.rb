class BookingInfo < ApplicationRecord 
  belongs_to :user 
  belongs_to :theater 
  belongs_to :screen 
  belongs_to :show

  validate :check_remaining_tickets

  # before_save :set_remaining_seats
 
  private

  def check_remaining_tickets

    if screen.remaining_seats.zero?
      errors.add(:base, "No more tickets available for this show.")
    elsif no_of_tickets.to_i > screen.remaining_seats
      errors.add(:no_of_tickets, "Only #{screen.remaining_seats} tickets remaining for this show.") 
    end
  end

  # def set_remaining_seats
  #   remaining_seats = (self.screen.total_seats - no_of_tickets)
  #   screen = Screen.find(self.screen.id)
  #   byebug
  #   update(remaining_seats: remaining_seats)
  # end
end

