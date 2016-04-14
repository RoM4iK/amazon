class RemoveShopPart < ActiveRecord::Migration
  def change
    drop_table "addresses"
    drop_table "countries"
    drop_table "credit_cards"
    drop_table "order_items"
    drop_table "orders"
  end
end
