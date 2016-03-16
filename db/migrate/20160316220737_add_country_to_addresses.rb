class AddCountryToAddresses < ActiveRecord::Migration
  def change
    change_table(:addresses) do |t|
      t.belongs_to :country
      t.remove :country
    end
  end
end
