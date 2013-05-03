class Hour < ActiveRecord::Base
  include Tag::Taggable
  include Note::Noteable

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_many :notes, :as => :noteable

  attr_accessible :user_id

  belongs_to :user
  has_many :dollars

  def number_for_user
    user.hours.index(self) + 1
  end

  def donors
    dollars.collect{|d| d.donation.user}
  end

  def days_ago
    ((Time.now - created_at) / (60 * 60 * 24)).floor
  end

  def most_recent_student_note
    notes.select{|n| n.has_tag?("Student") }.sort_by{|n| n.created_at}.last
  end

  def most_recent_teacher_note
    notes.select{|n| n.has_tag?("Teacher") }.sort_by{|n| n.created_at}.last
  end

  def add_student_note(text)
    note = note(text)
    note.tag("Student")
  end

  def add_teacher_note(text)
    note = note(text)
    note.tag("Teacher")
  end
end
