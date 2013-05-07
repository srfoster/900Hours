class Hour < ActiveRecord::Base
  include Tag::Taggable
  include Note::Noteable

  has_many :taggings, :as => :taggable
  has_many :tags, :through => :taggings
  has_many :notes, :as => :noteable

  attr_accessible :user_id

  belongs_to :user
  has_many :dollars

  #The last hour must be "complete" before we let them make a new hour.
  before_create :most_recent_hour_is_complete 

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
    notes.select{|n| n.has_tag?("Student") and !n.has_tag?("Deleted") }.sort_by{|n| n.created_at}.last
  end

  def most_recent_teacher_note
    notes.select{|n| n.has_tag?("Teacher") and !n.has_tag?("Deleted") }.sort_by{|n| n.created_at}.last
  end

  def add_student_note(text, user)
    note = note(text, user)
    note.tag("Student")
    note
  end

  def add_teacher_note(text, user)
    note = note(text, user)
    note.tag("Teacher")
    note
  end

  def previous_hour
    hours = user.hours.sort_by{|h| h.created_at}
    my_index = hours.index self
    if my_index == 0 
      return nil
    end
    
    return hours[my_index-1]
  end 

  def is_complete?
    !most_recent_student_note.nil? and !most_recent_teacher_note.nil?
  end

  
  def most_recent_hour
    user.hours.sort_by{|h| h.created_at}.last
  end 

  def most_recent_hour_is_complete
    complete = most_recent_hour.nil? || most_recent_hour.is_complete?

    if !complete
       errors[:base] << "Previous hour is not complete"    
       return false
    else
       return true
    end

  end

  def teacher
    return nil if most_recent_teacher_note.nil?

    return most_recent_teacher_note.owners.first #Presumably there is only one, right?
  end

  def dollars_from(user)
    dollars.select{|d| d.donation.user == user}.size
  end

  def donor_summary
    donors.uniq.collect{|d| {:id => d.id, :name => d.full_name, :amount => dollars_from(d)}}
  end

  def notes
    super.select{|n| !n.has_tag? "Deleted"}
  end
end
