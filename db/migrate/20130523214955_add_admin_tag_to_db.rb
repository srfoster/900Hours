class AddAdminTagToDb < ActiveRecord::Migration
  def up
    t = Tag.new
    t.name = "Admin"
    t.save
  end

  def down
    t = Tag.find_by_name("Admin")
    t.destroy
  end
end
