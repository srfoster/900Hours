class MakeAboutMeTag < ActiveRecord::Migration
  def up
    t = Tag.new
    t.name = "About Me"
    t.save
  end

  def down
    t = Tag.find_by_name "About Me"
    t.destroy
  end
end
