class EphemeralCredential < ActiveRecord::Base

  attr_accessible :secret, :username

  # association with the user model
  belongs_to :user

  def ttl
    "86400"
  end

  def uris
    ["turn: 50.116.13.218:3478?transport=udp"]
  end
end
