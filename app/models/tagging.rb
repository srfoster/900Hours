class Tagging < ActiveRecord::Base
  belongs_to :tag
  belongs_to :taggable, :polymorphic => true
  attr_accessible :tag, :taggable

  validates_presence_of :taggable
  validates_presence_of :tag
end
