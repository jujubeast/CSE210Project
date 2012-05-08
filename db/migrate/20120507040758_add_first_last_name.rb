class AddFirstLastName < ActiveRecord::Migration
  def up
  	change_table :users do |t|
  		t.string :email
  		t.string :picture_link
  	end
  end

  def down
  end
end
