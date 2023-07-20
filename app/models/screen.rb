class Screen < ApplicationRecord  
  belongs_to :theater
  has_many :shows, dependent: :destroy  
  has_many :booking_infos 
  has_many :slots , dependent: :destroy
  
  enum status: [:Idle, :Running, :Maintenance] 
   
  accepts_nested_attributes_for :slots
  validates :screen_name, presence: true  

  # before_save :update_remaining_seats 
   
  # private 
  
  # def update_remaining_seats
  #   if total_seats_changed? 
  #     self.remaining_seats = total_seats
  #   end
  # end 
end
