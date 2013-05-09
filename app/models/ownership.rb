class Ownership < ActiveRecord::Base
  include Tag::Taggable

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  belongs_to :owner, :foreign_key => "user_id", :class_name => "User"
  belongs_to :ownable, :polymorphic => true
  attr_accessible :ownable, :owner

  module Ownable
    def owned_by!(user)
      Ownership.create(:owner => user, :ownable => self)
    end
  end
end
