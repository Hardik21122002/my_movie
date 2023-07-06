class Screen < ApplicationRecord  
  belongs_to :theater
  has_many :shows, dependent: :destroy  
  has_many :booking_infos 
  has_many :slots , dependent: :destroy
  enum status: [:Idle, :Running, :Maintenance] 
  accepts_nested_attributes_for :slots
  validates :screen_name, presence: true 
end
