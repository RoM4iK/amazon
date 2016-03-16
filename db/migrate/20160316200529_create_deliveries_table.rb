class CreateDeliveriesTable < ActiveRecord::Migration
  def change
    create_table :deliveries do |t|
      t.string :name
      t.string :description
      t.integer :price
    end
  end
end
