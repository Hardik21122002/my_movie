class BookingInfoMailer < ApplicationMailer 

  def booking_confirmation(booking_info, user)
    @booking_info = booking_info
    @user = user
    mail(to: @user.email, subject: "Booking Confirmation for #{@booking_info}")
  end
end
