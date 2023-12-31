class ShowsController < ApplicationController 
  before_action :set_show, only: [:show, :edit, :update]
  before_action :authorize_admin, only: [:create, :destroy, :update, :edit, :show] 

  def index 
    @theaters = current_user.theaters
    @theater = Theater.find_by(id: session[:current_theater_id])
    @shows = @theater ? @theater.shows : [] 
  end
   
  def screen_shows
    screen = Screen.find(params[:screen_id])  
    shows = screen.shows
    render json: shows
  end  
 
  def screen_slots
    screen = Screen.find(params[:screen_id]) 
    slots = screen.slots
    render json: slots
  end  

  def show  
    @theaters = current_user.theaters
    authorize @show
  end  
  
  def new   
    @theaters = current_user.theaters    
    @show = Show.new  
    @slots = Slot.all
    @theater = Theater.find_by(id: session[:current_theater_id])
    @screens = @theater ? @theater.screens : []    
    render 'new' 
  end 
  
  def create   
    @show = Show.new(show_params)    
    @show.remaining_seats = @show.total_seats
    @theaters = current_user.theaters 
    @show.screen_id = params[:show][:screen_id] 
    
    if show_exists_at_same_time?(@show)
      redirect_to new_show_path , alert: "Another show is already scheduled for the selected screen at the specified time."     
    elsif @show.save 
      (params[:show][:time] || []).map { |time| @show.show_times.create(time: time) }     
      flash.now[:success] = "Show created"
      redirect_to shows_path 
    else
      flash.now[:error] = "Show creation failed"
      @screens = Screen.all
      render 'new'
    end
  end    
        
  def edit  
    @theaters = current_user.theaters
    authorize @show
    @screens = Screen.all
    @theater = @show.screen.theater
  end
  
  def update     
    @theaters = current_user.theaters 
    @screens = Screen.all
    authorize @show
    if @show.update(show_params)   
      flash.now[:success] = "Show updated"
      redirect_to @show
    else  
      render 'edit' 
    end
  end 
  
  def destroy    
    set_show
    Show.find(params[:id]).destroy 
    authorize @show
    flash.now[:success] = "Show deleted"
    redirect_to shows_url
  end   
  
  private   

  def show_exists_at_same_time?(show)
    existing_shows = Show.joins(:show_times).where(screen_id: show.screen_id, show_times: { time: show.show_times.map(&:time) }) 
    existing_shows.exists?
  end 

  def set_show
    @show = Show.find_by(id: params[:id])  
    if @show.nil?
      redirect_to shows_path, alert: "Show not found."
    end
  end 
  
  def show_params
    params.require(:show).permit(:name, :duration, :recurring, :start_date, :end_date, :theater_id,:screen_id,:total_seats,:remaining_seats,slot_ids: [], show_times_attributes: [:id, :time])
  end 
       
  def authorize_admin
    unless current_user&.theater_admin?
      redirect_to theater_path(current_user.theater_ids) , alert: "You are not authorized to perform this action."
    end
  end 

end
  