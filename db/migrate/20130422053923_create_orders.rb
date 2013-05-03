class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :token
      t.datetime :completed_at

      t.timestamps
    end
  end
end
