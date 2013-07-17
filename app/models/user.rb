class User < ActiveRecord::Base

  before_save :ensure_authentication_token

  # Include default devise modules. Others available are:
  # :omniauthable, :registerable, :confirmable, :recoverable
  # :lockable, :timeoutable
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :validatable

  # Association with the allocation model
  has_many :allocations, dependent: :destroy

  # Association with the customer model
  belongs_to :customer

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :max_allocs, :max_concur_allocs, :def_lifetime, 
                  :max_bandwidth, :first_name, :last_name, 
                  :turn_username, :turn_secret

  #def as_json(options={})
  #  super(:only => [:active_allocs, :allocs, :bandwidth_used, 
  #        :email, :first_name, :last_name])
  #end
end
