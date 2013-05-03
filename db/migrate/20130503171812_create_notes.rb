class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.text :note
      t.references :noteable, :polymorphic => true

      t.timestamps
    end
    add_index :notes, :noteable_id
  end
end
