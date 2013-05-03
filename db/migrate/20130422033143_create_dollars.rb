class CreateDollars < ActiveRecord::Migration
  def change
    create_table :dollars do |t|
      t.integer :donation_id
      t.integer :hour_id

      t.timestamps
    end
  end
end
