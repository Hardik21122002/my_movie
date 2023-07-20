class BookingInfosController < ApplicationController
  before_action :set_booking_info, only: [:show, :edit, :update, :destroy] 
  # before_action :authenticate_user!, only: [:create]
 
  def index  
    @booking_infos = current_user.booking_infos
    @theaters = current_user.theaters 
    @theater = @theaters.find_by(id: session[:current_theater_id])
    @booking_infos1 = @theater&.booking_infos  
  end
    
  def theater_screens
    theater = Theater.find_by(id: params[:theater_id])  
    screens = theater.screens
    render json: screens
  end 

  def screens_shows
    screen =  Screen.find_by(id: params[:screen_id])
    shows = screen.shows
    render json: shows
  end

  def shows_booking_dates
    @show = Show.find_by(id: params[:show_id])
  
    start_date = @show.start_date.to_date
    end_date = (@show.end_date || @show.start_date).to_date
    today = Date.today
    booking_dates = []
  
    (start_date..end_date).each do |date|
      booking_dates << { id: @show.id, start_date: date.to_s } if date >= today
    end
    render json: booking_dates
  end
    
  def booking_dates_times
    @show = Show.find_by(id: params[:show_id])
    booking_times = @show.show_times.pluck(:time).map { |time| time.strftime("%I:%M %p") }
    render json: { booking_times: booking_times }
  end
  
  def show 
    @theaters = current_user.theaters 
    authorize @booking_info
  end

  def new 
    @booking_info = BookingInfo.new   
    @theater = Theater.all
    @users = User.all  
    @screens = Screen.all 
    @shows = Show.all
  end  
 
  def create   
    @booking_info = BookingInfo.new(booking_info_params)  
    @booking_info.user = current_user   
    booked_tickets = @booking_info.no_of_tickets.to_i
    if @booking_info.save 
     
      # update_remaining_seats(@booking_info.show, @booking_info.screen, @booking_info.booking_date, booked_tickets)
     
      BookingInfoMailer.booking_confirmation(@booking_info, current_user).deliver_now
      flash[:success] = "BookingInfo created"      
      redirect_to booking_infos_url
    else
      flash.now[:error] = "BookingInfo creation failed"  
      @theaters = Theater.all
      @users = User.all  
      @screens = Screen.all 
      @shows = Show.all
      render 'new'
    end 
  end 

  def edit  
    authorize @booking_info 
    @theaters = current_user.theaters
    @theater = Theater.find_by(id: session[:current_theater_id])
  end 

  def update   
    authorize @booking_info
    if @booking_info.update(booking_info_params)  
      flash[:success] = "BookingInfo updated"
      redirect_to @booking_info
    else  
      render 'edit' 
    end
  end   

  def destroy 
    BookingInfo.find_by(id: params[:id]).destroy 
    authorize @booking_info
    flash[:success] = "BookingInfo deleted"
    redirect_to booking_infos_url
  end    

  private  

  # def update_remaining_seats(show, screen, date, booked_tickets)
  #   if show.start_date <= date && date <= (show.end_date || show.start_date)
  #     if date == Date.current
  #       screen.remaining_seats -= booked_tickets
  #       screen.save
  #     end
  #   end
  # end 
   
  def booking_info_params
    params.require(:booking_info).permit(:booking_date, :booking_time,:theater_id, :screen_id, :show_id, :no_of_tickets) 
  end  

  def set_booking_info 
    @booking_info = BookingInfo.find_by(id: params[:id])
    if @booking_info.nil?
      redirect_to booking_infos_path, alert: "BookingInfo not found."
    end
  end  
end
