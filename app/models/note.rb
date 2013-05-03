class Note < ActiveRecord::Base
  include Tag::Taggable

  attr_accessible :note, :noteable

  belongs_to :noteable, :polymorphic=>true

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  module Noteable
    def note(text)
      note = Note.new
      note.note = text
      notes << note
      return note
    end
  end
end
