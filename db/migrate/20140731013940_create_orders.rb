class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :production_id
      t.string :desc

      t.timestamps
    end
  end
end
