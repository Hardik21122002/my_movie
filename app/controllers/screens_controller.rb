class ScreensController < ApplicationController 
  before_action :set_screen, only: [:show, :edit, :update]
  before_action :authorize_admin, only: [:create, :destroy, :update, :edit, :show]

  def index 
    @theaters = current_user.theaters
    @theater = Theater.find_by(id: session[:current_theater_id])
    @screens = @theater ? @theater.screens : []
  end
  
  # def theater_screens
  #   theater = Theater.find(params[:theater_id])  
  #   screens = theater.screens
  #   render json: screens
  # end 
  
  def show  
    # @screen = Screen.find(params[:id])   
    @theaters = current_user.theaters   
    authorize @screen
  end 

  def new
    @screen = Screen.new  
    @theaters = current_user.theaters  
    @theater = Theater.find_by(id: session[:current_theater_id])
    @users = User.all
    render 'new'
  end
  

  def create
    @screen = Screen.new(screen_params) 
    @screen.theater_id = params[:screen][:theater_id] 
    authorize @screen
    if @screen.save
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
    # @screen = Screen.find(params[:id]) 
    authorize @screen
    @theaters = current_user.theaters  
    @theater = @screen.theater
    @users = User.all
  end
  

  def update 
    # @screen = Screen.find(params[:id]) 
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
    params.require(:screen).permit(:screen_name, :screen_type, :status, :theater_id,:user_id, slots_attributes: [:id, :start_time,:end_time])
  end
  
  def authorize_admin 

    unless current_user&.theater_admin?
      redirect_to theater_path(current_user.theater_ids) , alert: "You are not authorized to perform this action."
    end
  end 

end
