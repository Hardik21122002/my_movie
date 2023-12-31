class Theater < ApplicationRecord  
    # before_create :generate_secure_hash
    has_many :screens, dependent: :destroy
    has_many :shows, through: :screens 
    has_many :booking_infos, dependent: :destroy
    has_many :reviews, dependent: :destroy  

    has_many :theater_users ,dependent: :destroy
    has_many :users, through: :theater_users  ,dependent: :destroy  


    accepts_nested_attributes_for :users, allow_destroy: true 
    accepts_nested_attributes_for :screens, allow_destroy: true   


end
