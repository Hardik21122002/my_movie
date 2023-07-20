class ScreensController < ApplicationController 
  before_action :set_screen, only: [:show, :edit, :update]
  
  def index 
    @theaters = current_user.theaters
    @theater = @theaters.find_by(id: session[:current_theater_id]) 
    @screens = @theater&.screens 
  end
  
  def show  
    @theaters = current_user.theaters   
    authorize @screen
  end 

  def new
    @screen = Screen.new  
    @theaters = current_user.theaters  
    @theater = @theaters.find_by(id: session[:current_theater_id])
  end
  
  def create
    @screen = Screen.new(screen_params) 
    @screen.theater_id = params[:screen][:theater_id] 
    authorize @screen
    if @screen.save    
      byebug
      flash.now[:success] = "Screen created"
      redirect_to screens_path
    else
      flash.now[:error] = "Screen creation failed"  
      @theaters = Theater.all
      @users = User.all
      render 'new'
    end
  end
  
  def edit
    authorize @screen
    @theaters = current_user.theaters  
    @theater = @screen.theater
  end
  
  def update   
    if @screen.update(screen_params)  
      flash.now[:success] = "Screen updated"
      redirect_to @screen
    else  
      render 'edit' 
    end
  end   
  
  def destroy 
    Screen.find(params[:id]).destroy
    flash.now[:success] = "Screen deleted"
    redirect_to screens_url
  end   

  private   
  
  def set_screen
    @screen = Screen.find_by(id: params[:id])  
    if @screen.nil?
      redirect_to screens_path, alert: "Screen not found."
    end
  end
  
  def screen_params
    params.require(:screen).permit(:screen_name, :status, :theater_id,:user_id,:total_seats,:remaining_seats, slots_attributes: [:id, :start_time,:end_time])
  end 
end
