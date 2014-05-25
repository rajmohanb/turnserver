class Customer < ActiveRecord::Base

  extend FriendlyId
  friendly_id :organization, use: :slugged

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :omniauthable
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :timeoutable, :lockable,
         :registerable, :confirmable, :recoverable, :validatable

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me

  attr_accessible :realm, :organization, :first_name, :last_name

  # Association with the user model
  has_many :users, dependent: :destroy

  # Association with the allocation model
  has_many :allocations, through: :users

  validates_presence_of :first_name, :last_name, :organization
  validates_uniqueness_of :organization
end
