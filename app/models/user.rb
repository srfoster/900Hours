class User < ActiveRecord::Base
  include Note::Noteable
  include Tag::Taggable

  attr_accessible :first_name, :last_name, :picture, :picture_cache
  has_many :orders
  has_many :donations
  has_many :hours

  has_many :ownerships

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_many :notes, :as => :noteable

  has_many :application_requests

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

  def self.find_or_create_from_provider_info(info)
    u = find_by_provider_info(info)
    if u
        return u
    end

    create_from_provider_info(info) 
  end

  def self.find_by_provider_info(info)
    identity = Identity.find_by_uid(info["uid"])
    if identity.nil?
        return nil
    else
        return identity.user
    end
  end

  def self.create_from_provider_info(info)
    user = User.new

    user.first_name = info["info"]["first_name"]
    user.last_name = info["info"]["last_name"]

    user.save

    identity = Identity.new
    identity.user_id  = user.id
    identity.provider = "thoughtstem"
    identity.uid      = info["uid"]
    identity.save

    user.set_about_me("")

    return user
  end

  def picture_url
    if picture.url
      return picture.url.gsub "https", "http"
    else
      return '/assets/question_mark.png'
    end
  end

  def is_donor?
    !donated_hours.blank?
  end

  def donated_hours
    donations.collect{|d| d.dollars}.flatten.collect{|d| d.hour}.uniq 
  end

  def taught_hours
    owned_notes.select{|o| o.noteable_type == "Hour"}.collect{|o| o.noteable }.uniq
  end

  def all_hours
    (hours + donated_hours + taught_hours).uniq.sort_by{|h| h.created_at}
  end

  def note_ownerships
    ownerships.select{|o| o.ownable_type == "Note" }
  end

  def owned_notes
    note_ownerships.collect{|o| o.ownable} - [nil]
  end


  #application requests
  
  def is_approved_student?
    !application_requests.select{|a| a.is_approved? and a.has_tag?("Student") }.blank?
  end

  def is_approved_teacher?
    !application_requests.select{|a| a.is_approved? and a.has_tag?("Teacher") }.blank?
  end

  def has_pending_student_requests?
    !application_requests.select{|a| a.is_pending? and a.has_tag?("Student") }.blank?
  end

  def has_pending_teacher_requests?
    !application_requests.select{|a| a.is_pending? and a.has_tag?("Teacher") }.blank?
  end

  def has_pending_requests?
    !pending_requests.blank?
  end


  def pending_requests
    application_requests.select{|a| a.is_pending?}
  end

  def pending_request
    pending_requests.first
  end

  def is_admin?
    has_tag? "Admin"
  end

end
