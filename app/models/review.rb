class Review < ApplicationRecord
  belongs_to :user
  belongs_to :show
  belongs_to :theater 

  validates :rating, presence: true  
  validates :feedback, presence: true  
 
end
