class ApplicationController < ActionController::Base   
 
  include Pundit::Authorization

    protect_from_forgery with: :exception

    protect_from_forgery with: :null_session
    skip_before_action :verify_authenticity_token
    before_action :authenticate_user!
    skip_before_action :authenticate_user!, if: -> { request.path.start_with?('/admin')  }
  
    rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
    
    def set_theater
      session[:current_theater_id] = params[:theater_id]
      render json: {}
    end

    private  
    

    def user_not_authorized
      flash[:alert] = "You are not authorized to perform this action."
      redirect_to theater_path(current_user.theater_ids) 
    end 

end
