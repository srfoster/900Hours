class Dollar < ActiveRecord::Base
  attr_accessible :donation, :hour, :donation_id, :hour_id

  belongs_to :donation
  belongs_to :hour

  before_create :check_donation

  def check_donation
    return !(donation.unallocated_dollars <= 0)
  end
end
