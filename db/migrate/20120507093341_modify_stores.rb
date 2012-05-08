class ModifyStores < ActiveRecord::Migration
  def up
  	change_table :stores do |t|
  		t.boolean :been_to
  		t.boolean :can_delete
  		t.boolean :favorite
  		t.string :image
  		
  	end
  end

  def down
  end
end
