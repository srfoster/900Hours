class AddDeletedTag < ActiveRecord::Migration
  def up
    Tag.create(:name => "Deleted")
  end

  def down
    tag = Tag.find_by_name("Deleted")
    tag.destroy
  end
end
