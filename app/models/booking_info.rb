class BookingInfo < ApplicationRecord 
  belongs_to :user 
  belongs_to :theater 
  belongs_to :screen 
  belongs_to :show

  validate :check_remaining_tickets
 
  private

  def check_remaining_tickets
    if show && show.remaining_seats.zero?
      errors.add(:base, "No more tickets available for this show.")
    elsif show && no_of_tickets.to_i > show.remaining_seats
      errors.add(:no_of_tickets, "Only #{show.remaining_seats} tickets remaining for this show.")
    end
  end
  
end

