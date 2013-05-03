class CreatePaypalLogs < ActiveRecord::Migration
  def change
    create_table :paypal_logs do |t|
      t.integer :order_id
      t.text :message

      t.timestamps
    end
  end
end
