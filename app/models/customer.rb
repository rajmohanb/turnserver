class Customer < ActiveRecord::Base

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :omniauthable, :validatable
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :timeoutable, :lockable,
         :registerable, :confirmable, :recoverable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :realm, :organization, :first_name, :last_name

  # Association with the user model
  has_many :users, dependent: :destroy

  # Association with the allocation model
  has_many :allocations, through: :users
end
