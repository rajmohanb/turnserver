class Message

  include ActiveAttr::Model

  attribute :name
  attribute :email
  attribute :company
  attribute :subject
  attribute :content

  attr_accessor :name, :email, :company, :subject, :content

  validates_presence_of :name
  validates_format_of :email, :with => /^[-a-z0-9_+\.]+\@([-a-z0-9]+\.)+[a-z0-9]{2,4}$/i
  validates_presence_of :company
  validates_presence_of :subject
  validates_presence_of :content
  validates_length_of :content, :maximum => 500

end
