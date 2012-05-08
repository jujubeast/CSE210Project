class CreateListsStores < ActiveRecord::Migration
  def change
    create_table :lists_stores do |t|

      t.timestamps
    end
  end
end
