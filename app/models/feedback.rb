class Feedback < ActiveRecord::Base
  belongs_to :user
  belongs_to :puzzle
  attr_accessible :difficulty, :quality
end
