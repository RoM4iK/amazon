class AddAdminToCustomers < ActiveRecord::Migration
  def change
    change_table(:customers) do |t|
      t.boolean   :admin
    end
  end
end
