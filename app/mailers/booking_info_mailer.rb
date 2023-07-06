class BookingInfoMailer < ApplicationMailer 
    
    def booking_confirmation
      @booking_info = params[:booking_info]
      @user = params[:user]
      mail(to: @user.email, subject: "Booking Confirmation")
    end 
   
end
