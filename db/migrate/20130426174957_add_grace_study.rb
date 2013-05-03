class AddGraceStudy < ActiveRecord::Migration
  def up
    grace = User.new
    grace.first_name = "Grace"
    grace.last_name  = "Manning" 
    grace.save

    0.upto(72) do |i|
      hour = Hour.new
      hour.user = grace
      hour.save 
    end

    Tagging.create(:tag => Tag.find_by_name("case_study"), :taggable => grace)
  end

  def down
    grace = Tagging.find_all_by_tag(Tag.find_by_name("case_study")).select{|t| t.taggable.first_name == "Grace" and t.taggable.last_name == "Manning"}.first
    grace.destroy
  end
end
