class ReviewsController < ApplicationController  
    before_action :authorize_user_access, only: [:show]

    def index 
        @reviews = current_user.reviews.order(created_at: :desc) 
    end 

    def show 
        @review = Review.find(params[:id])
    end  

    def new 
        @review = Review.new 
        @theaters = Theater.all  
        @shows = Show.all  
        @booking_info = BookingInfo.find(params[:booking_info_id]) if params[:booking_info_id].present?
        
        if @booking_info.present?
          @review.theater_id = @booking_info.theater_id
          @review.show_id = @booking_info.show_id
        end
    end
      
    def create  
        @review = Review.new(review_params) 
        @review.user = current_user   
        theater_name = params[:review][:theater]
        @review.theater = Theater.find_by(name: theater_name) if theater_name.present?
      
        show_name = params[:review][:show]
        @review.show= Show.find_by(name: show_name) if show_name.present?
        if @review.save 
            flash.now[:success] = "Review Created" 
            redirect_to reviews_path
        else  
            flash.now[:error] = "Review Creation Failed " 
            @shows = Show.all 
            @theaters = Theater.all  
            render 'new'
        end 
    end    
    
    def destroy 
        Review.find(params[:id]).destroy
        flash.now[:success] = "Screen deleted"
        redirect_to reviews_url
    end  
    

    private 

    def review_params  
        params.require(:review).permit(:rating, :feedback, :show_id, :theater_id)
    end 
     
    def authorize_user_access
        @review = Review.find(params[:id])
        unless current_user == @review.user
          redirect_to root_path, alert: "You are not authorized to perform this action."
        end
      end
end
