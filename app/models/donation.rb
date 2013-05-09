class Donation < ActiveRecord::Base
  attr_accessible :amount, :user_id, :recipient_id
  belongs_to :user
  has_many :dollars
end
