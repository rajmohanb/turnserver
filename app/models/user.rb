class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable, :registerable, :confirmable, :recoverable
  # :lockable, :timeoutable and 
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # attr_accessible :title, :body
end
