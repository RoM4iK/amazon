class AddDeliveryToOrders < ActiveRecord::Migration
  def change
    change_table(:orders) do |t|
      t.belongs_to :delivery
    end
  end
end
