class BookingInfosController < ApplicationController
  before_action :set_booking_info, only: [:show, :edit, :update, :destroy]  
  before_action :authorize_admin, only: [:destroy,:edit, :update]

  def index  
    @booking_infos = current_user.booking_infos
    @theaters = current_user.theaters
    @theater = Theater.find_by(id: session[:current_theater_id])
    @booking_infos1 = @theater ? @theater.booking_infos : []
  end
    
  def theater_screens
    theater_id = params[:theater_id]
    screens = Screen.where(theater_id: theater_id)
    render json: screens
  end

  def screens_shows
    screen_id = params[:screen_id]
    shows = Show.where(screen_id: screen_id)
    render json: shows
  end
  
  def shows_booking_dates
    show_id = params[:show_id]
    @show = Show.find_by(id: show_id)
  
    if @show.end_date.nil?
      @show.end_date = @show.start_date
    end
  
    start_date = @show.start_date.to_date
    end_date = @show.end_date.to_date
    today = Date.today
  
    booking_dates = []
  
    (start_date..end_date).each do |date|
      booking_dates << { id: @show.id, start_date: date.to_s } if date >= today
    end
    render json: booking_dates
  end
    
  def booking_dates_times
    show_id = params[:show_id]
    @show = Show.find_by(id: show_id)
    booking_times = @show.show_times.pluck(:time).map { |time| time.strftime("%I:%M %p") }
    render json: { booking_times: booking_times }
  end
  
  def show 
    @theaters = current_user.theaters
  end

  def new 
    @booking_info = BookingInfo.new   
    @theater = Theater.all
    @users = User.all  
    @screens = Screen.all 
    @shows = Show.all
    render 'new'
  end  
 
  def create   
  
    @booking_info = BookingInfo.new(booking_info_params)  
    @booking_info.user = current_user  
    @show = Show.find(params[:booking_info][:show_id])
    booked_tickets = @booking_info.no_of_tickets.to_i
    if @booking_info.save 

      update_remaining_seats(@show, @booking_info.booking_date, booked_tickets)
     
      BookingInfoMailer.with(booking_info: @booking_info, user: current_user).booking_confirmation.deliver_now
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
    @users = User.all  
    @screens = Screen.all 
    @shows = Show.all 
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
    BookingInfo.find(params[:id]).destroy 
    authorize @booking_info
    flash[:success] = "BookingInfo deleted"
    redirect_to booking_infos_url
  end    

  private  

  def booking_info_params
    params.require(:booking_info).permit(:screen_type, :number, :booking_date, :booking_time,:theater_id, :screen_id, :show_id, :no_of_tickets) 
  end  

  def update_remaining_seats(show, date, booked_tickets)
    if show.end_date.nil?
      show.end_date = show.start_date
    end

    if show.start_date <= date && date <= show.end_date 
      if date == Date.current
        show.remaining_seats -= booked_tickets
        show.save 
      end
    end
  end 

  def set_booking_info
    @booking_info = BookingInfo.find_by(id: params[:id])
    if @booking_info.nil?
      redirect_to booking_infos_path, alert: "BookingInfo not found."
    elsif current_user.theater_admin? && !current_user.theaters.exists?(@booking_info.theater_id)
      redirect_to theater_path(current_user.theater_ids), alert: "You are not authorized to perform this action."
    end
  end 
   
  def authorize_admin
    unless current_user&.theater_admin? 
      redirect_to theater_path(current_user.theater_ids) , alert: "You are not authorized to perform this action."
    end 
  end 
  
end
