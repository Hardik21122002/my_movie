class Show < ApplicationRecord
  belongs_to :screen 
  belongs_to :theater 
  has_many :booking_infos,dependent: :destroy
  has_many :reviews, dependent: :destroy  
  has_many :show_times, dependent: :destroy  

  has_many :show_slots ,dependent: :destroy
  has_many :slots, through: :show_slots ,dependent: :destroy  
 
  accepts_nested_attributes_for :show_times  
  validate :not_past_date   
  validate :time_within_screen_slot  
  validate :time_within_duration   
  validates :duration, presence: true

  def not_past_date
    if start_date.present? && start_date < Date.today
      errors.add(:date, 'Please select a proper date')
    end
  end   

  def formatted_time
    time.strftime("%I:%M %p")
  end
   
  def average_rating
    reviews.average(:rating)
  end 
  
  private
  
  def time_within_screen_slot  
    duration  = self.duration
    slot_ids = slots.map(&:id)   
    time_values = show_times.map(&:time).compact  
    time_values.each do |t|  
      slot_ids.each_with_index do |id, index|     
        if (t.strftime("%I:%M %p")  >= Slot.find(id).start_time.strftime("%I:%M %p") ) && (t.strftime("%I:%M %p")  <= Slot.find(id).end_time.strftime("%I:%M %p") )
          new_time = t + duration
          if new_time.strftime("%H:%M") > Slot.find(id).end_time.strftime("%H:%M")
            errors.add(:time, "Please enter valid  duration" )
            break 
          else
            break
          end
        else 
          if slot_ids[index + 1].nil?
            errors.add(:time, "Please add time related to screen slot" )  
          end
        end  
      end
    end 
  end  

  def time_within_duration 
    duration_hours = duration.strftime("%H").to_i  
    duration_minutes = duration.strftime("%M").to_i
    
    time_values = show_times.map(&:time).compact
    time_values_in_minutes = time_values.map { |time| time.hour * 60 + time.min }

    time_values_in_minutes.each_with_index do |time, index|
      break if index == time_values_in_minutes.length - 1

      next_time = time_values_in_minutes[index + 1]
      if next_time < time + duration_hours * 60 + duration_minutes
        errors.add(:time, "Please add time values in the correct order based on duration")
        return
      end
    end
  end 
end

