# This migration comes from shopper_engine (originally 20160401124723)
class CreateShopperEngineDeliveries < ActiveRecord::Migration
  def change
    create_table :shopper_engine_deliveries do |t|
      t.string  :name
      t.string  :description
      t.integer :price
      t.timestamps null: false
    end
  end
end
