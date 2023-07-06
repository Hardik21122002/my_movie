class TheatersController < ApplicationController 
  before_action :authorize_theater_access, only: [:show] 
  before_action :set_current_theater, only: [:show]
 
  def index
    @theaters = Theater.all
  end
  
  def show 
    @theater = Theater.find(params[:id])    
    @theaters = current_user.theaters
    @bookings = BookingInfo.where(theater_id: @theater.id, booking_date: Date.today.beginning_of_week..Date.today.end_of_week)
    @bookings_by_show = @bookings.group(:show_id).count 
    
    @theater_screen = Screen.where(theater_id: @theater.id) 
    @theater_review = Review.where(theater_id: @theater.id)  
    @reviews = @theater_review 
    @shows = @theater.shows
   
    @names = []
    @total_bookings = []

    @bookings_by_show.each do |show_id, bookings_count|
      show = Show.find(show_id)
      @names << show.name
      @total_bookings << bookings_count
    end
    @bookings_by_week = BookingInfo.where(theater_id: @theater.id).group_by_week(:booking_date, format: "%d-%m-%Y").count
    @bookings_by_month = BookingInfo.where(theater_id: @theater.id).group_by_month(:booking_date, format: "%b-%Y").count
     
    @popular_show_data = BookingInfo.joins(:show).where(theater_id: @theater.id).group('shows.name').count
    @booking_info_theater = @theater.booking_infos  #
  end    
  private 

  def set_current_theater
    session[:current_theater_id] = params[:id]
  end

  def authorize_theater_access
    theater = current_user.theaters.find_by(id: params[:id])
    unless theater
      redirect_to theater_path(current_user.theater_ids), alert:  "You are not authorized to perform this action."
    end
  end  

end 
