class Tag < ActiveRecord::Base
  attr_accessible :name

  validates :name, :uniqueness => true


  module Taggable
   
    def tag(name)
      if has_tag? name
          return
      end

      tagging = Tagging.new
      tagging.taggable = self
      tagging.tag = Tag.find_by_name(name)
      tagging.save
    end

    def untag(name)
      taggings.select{|t| t.tag.name == name}.each{|t| t.destroy}
    end

    def has_tag?(name)
      !tags.select{|t| t.name == name }.blank?
    end
  end
end
