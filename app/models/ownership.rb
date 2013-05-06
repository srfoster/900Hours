class Ownership < ActiveRecord::Base
  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"
  belongs_to :ownable, :polymorphic => true
  attr_accessible :ownable, :owner

  module Ownable
    def owned_by!(user)
      Ownership.create(:owner => user, :ownable => self)
    end
  end
end
