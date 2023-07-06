class HomeController < ApplicationController 
  skip_before_action :authenticate_user!, only: [:edit_password, :reset_password]

  def index
    if current_user.theater_admin?
      @theaters = current_user.theaters
      session[:current_theater_id] ||= @theaters.first.id if @theaters.present?
      redirect_to theater_path(current_user.theater_ids)
    else
      start_of_week = Date.current.beginning_of_week
      # end_of_week = Date.current.end_of_week  
      end_date = Date.current 
      # @shows = Show.where("start_date <= ? AND end_date >= ?", end_of_week, start_of_week) 
      # @shows = Show.where("start_date <= ? AND end_date >= ? ", end_date, start_of_week)  
      @shows = Show.where("(start_date <= ? AND end_date >= ?) OR ( start_date = ? AND end_date IS NULL) ",end_date, start_of_week,Date.today) 
      @selected_show = nil   
    end
  end
  
  def edit_password   
    @disable_nav = true
  end
  
  def reset_password 
    user = User.find_by(email: params[:email])
    new_password = params[:new_password]
    confirm_password = params[:confirm_new_password]
    if (new_password == confirm_password)
      user.update(password: new_password, password_confirmation: confirm_password)
      flash.now[:notice]= "Your password has changed successfully"
      redirect_to new_user_session_path
    else
      flash[:notice]= "Passwords are not matching, please re-enter password"
      redirect_to edit_password_path
    end
  end
end

