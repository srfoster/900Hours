class User < ActiveRecord::Base
  include Note::Noteable
  include Tag::Taggable

  attr_accessible :first_name, :last_name, :picture, :picture_cache
  has_many :orders
  has_many :donations
  has_many :hours

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_many :notes, :as => :noteable

  mount_uploader :picture, PictureUploader

  def about_me
    notes.select{|n| n.has_tag?("About Me") }.sort_by{|n| n.created_at}.last
  end

  def set_about_me(text)
    note = note(text, self)
    note.tag("About Me")
  end

  def full_name
    first_name + " " + last_name
  end

  def self.find_by_facebook_info(info)
    identity = Identity.find_by_uid(info["uid"])
    if identity.nil?
        return nil
    else
        return identity.user
    end
  end

  def self.create_from_facebook_info(info)
    user = User.new

    user.first_name = info["info"]["first_name"]
    user.last_name = info["info"]["last_name"]

    user.save

    identity = Identity.new
    identity.user_id  = user.id
    identity.provider = "facebook"
    identity.uid      = info["uid"]
    identity.save

    set_about_me("")

    return user
  end

  def picture_url
    if picture.url
      return picture.url.gsub "https", "http"
    else
      return '/assets/question_mark.png'
    end
  end
end
