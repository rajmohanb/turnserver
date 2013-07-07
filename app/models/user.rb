class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :omniauthable, :registerable, :confirmable, :recoverable
  # :lockable, :timeoutable and 
  devise :database_authenticatable, :token_authenticatable,
         :rememberable, :trackable, :validatable

  # Association with the allocation model
  has_many :allocations, dependent: :destroy

  # Association with the customer model
  belongs_to :customer

  # Setup accessible (or protected) attributes for your model
  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :max_allocs, :max_concur_allocs, :turn_secret, :def_lifetime,
                  :max_bandwidth, :first_name, :last_name
end
