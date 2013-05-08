class Dollar < ActiveRecord::Base
  attr_accessible :donation, :hour, :donation_id, :hour_id

  belongs_to :donation
  belongs_to :hour
end
