class CreateApplicationRequests < ActiveRecord::Migration
  def up
    create_table :application_requests do |t|
      t.references :user

      t.timestamps
    end
    add_index :application_requests, :user_id

    Tag.create(:name => "Approved")
    Tag.create(:name => "Rejected")
  end

  def down
    drop_table :application_requests

    Tag.find_by_name("Approved").destroy
    Tag.find_by_name("Rejected").destroy
  end
end
