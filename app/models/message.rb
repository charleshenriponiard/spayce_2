class Message
  include ActiveModel::Model
  attr_accessor :subject, :body

  validates_presence_of :body
  validates_presence_of :subject
end
