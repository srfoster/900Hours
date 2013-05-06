class Note < ActiveRecord::Base
  include Tag::Taggable
  include Ownership::Ownable

  attr_accessible :note, :noteable

  belongs_to :noteable, :polymorphic=>true

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  has_many :ownerships, :as => :ownable
  has_many :owners, :through => :ownerships

  module Noteable
    def note(text, user)
      note = Note.new
      note.note = text
      notes << note
      note.owned_by! user      

      return note
    end
  end
end
