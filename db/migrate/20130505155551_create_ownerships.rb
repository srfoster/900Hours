class CreateOwnerships < ActiveRecord::Migration
  def change
    create_table :ownerships do |t|
      t.references :user
      t.integer :ownable_id
      t.string :ownable_type

      t.timestamps
    end
    add_index :ownerships, :user_id
    add_index :ownerships, :ownable_id
  end
end
