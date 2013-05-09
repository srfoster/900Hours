class ApplicationRequest < ActiveRecord::Base
  include Tag::Taggable

  attr_accessible :user_id

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings

  belongs_to :user

  def approve!
      tag("Approved")
      untag("Rejected")
      untag("Deleted")
  end

  def reject!
      tag("Rejected")
      untag("Approved")
      untag("Deleted")
  end

  def cancel!
      tag("Deleted")
      untag("Rejected")
      untag("Approved")
  end

  def is_approved?
      has_tag?("Approved")
  end

  def is_rejected?
      has_tag?("Rejected")
  end

  def is_pending?
      !has_tag?("Approved") and !has_tag?("Rejected") and !has_tag?("Deleted")
  end

  def self.create_new_student_request(user)
    if user.has_pending_requests?
       return false
    end

    req = ApplicationRequest.new
    req.user = user
    req.save
    req.tag "Student"
    req
  end

  def self.create_new_teacher_request(user)
    if user.has_pending_requests?
       return false
    end

    req = ApplicationRequest.new
    req.user = user
    req.save
    req.tag "Teacher"
    req
  end

end
