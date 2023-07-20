class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable 
  has_many :booking_infos 
  has_many :reviews, dependent: :destroy
  enum role: [:user, :theater_admin] 
  
  has_many :theater_users 
  has_many :theaters, through: :theater_users ,dependent: :destroy 
  
  before_create :generate_password
  after_create :send_password_reset_email 

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable 

  def generate_password
    self.password ||= SecureRandom.hex(8)
  end

  def send_password_reset_email
    UserMailer.default_password(self).deliver_now
  end
end
