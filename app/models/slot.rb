class Slot < ApplicationRecord
  belongs_to :screen   
  
  has_many :show_slots ,dependent: :destroy
  has_many :shows, through: :show_slots  ,dependent: :destroy

  def start_time_and_end_time
    "#{start_time&.strftime('%I:%M %p')} - #{end_time&.strftime('%I:%M %p')}"
  end
end

