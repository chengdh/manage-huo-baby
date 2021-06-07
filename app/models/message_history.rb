class MessageHistory < ActiveRecord::Base
  belongs_to :message
  belongs_to :user
  # attr_accessible :title, :body
end
