class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :email

  #after_create :send_signup_email
  
  # def send_signup_email
  #   UserMailer.signup_confirmation(@user).deliver
  # end
end
