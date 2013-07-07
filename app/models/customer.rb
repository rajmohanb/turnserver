class Customer < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable, :confirmable, :registerable, :recoverable
  # :validatable
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :timeoutable, :lockable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :realm, :first_name, :last_name

  # Association with the user model
  has_many :users, dependent: :destroy

  # Association with the allocation model
  has_many :allocations, through: :users
end
