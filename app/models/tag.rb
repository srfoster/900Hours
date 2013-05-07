class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true


  module Taggable
   
    def tag(name)
      tagging = Tagging.new
      tagging.taggable = self
      tagging.tag = Tag.find_by_name(name)
      tagging.save
    end

    def has_tag?(name)
      !tags.select{|t| t.name == name }.blank?
    end
  end
end
