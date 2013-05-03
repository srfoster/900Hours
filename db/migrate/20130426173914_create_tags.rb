class CreateTags < ActiveRecord::Migration
  def up
    create_table :tags do |t|
      t.string :name

      t.timestamps
    end

    Tag.create :name => "case_study"
  end

  def down
    drop_table :tags
  end
end
