class User < ActiveRecord::Base

  extend FriendlyId
  friendly_id :first_name, use: :slugged

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :omniauthable, :registerable, :confirmable, :recoverable
  # :lockable, :timeoutable, :token_authenticatable
  devise :database_authenticatable, :rememberable, :trackable, :validatable

  # Association with the allocation model
  has_many :allocations, dependent: :destroy

  # Association with the webrtc ephemeral credentials
  has_many :ephemeral_credentials, dependent: :destroy

  # Association with the customer model
  belongs_to :customer

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :max_allocs, :max_concur_allocs, :def_lifetime, 
                  :max_bandwidth, :first_name, :last_name, 
                  :turn_username, :turn_secret

  # capitalize the first letter
  def first_name=(val)
    write_attribute(:first_name, val.titleize)
  end

  def last_name=(val)
    write_attribute(:last_name, val.capitalize)
  end
 
  #def as_json(options={})
  #  super(:only => [:active_allocs, :allocs, :bandwidth_used, 
  #        :email, :first_name, :last_name])
  #end
end
