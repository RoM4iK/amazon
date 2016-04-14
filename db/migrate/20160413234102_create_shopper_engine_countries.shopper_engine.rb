# This migration comes from shopper_engine (originally 20160401124700)
class CreateShopperEngineCountries < ActiveRecord::Migration
  def change
    create_table :shopper_engine_countries do |t|
      t.string   :name
      t.belongs_to :address
      t.timestamps null: false
    end
  end
end
