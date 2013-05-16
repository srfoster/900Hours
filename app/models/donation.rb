class Donation < ActiveRecord::Base
  attr_accessible :amount, :user_id, :recipient_id
  belongs_to :user
  has_many :dollars


  def unallocated_dollars
    amount - dollars.size
  end

  def allocate_for(hour, num = 1)
    1.upto num do
        dollar = Dollar.new
        dollar.donation = self
        dollar.hour = hour
        dollar.save
    end
  end

end
