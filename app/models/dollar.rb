class Dollar < ActiveRecord::Base
  attr_accessible :donation, :hour

  belongs_to :donation
  belongs_to :hour
end
