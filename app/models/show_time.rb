class ShowTime < ApplicationRecord 
  belongs_to :show    
  validates :time, presence: true   

end


