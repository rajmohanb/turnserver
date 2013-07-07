class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable, :registerable, :confirmable, :recoverable
  # :lockable, :timeoutable and 
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  # Association with the allocation model
  has_many :allocations, dependent: :destroy

  # Association with the customer model
  belongs_to :customer

  # attr_accessible :title, :body
end
