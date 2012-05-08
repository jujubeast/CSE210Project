class AddPwToUsers < ActiveRecord::Migration
  def change
  	change_table :users do |t|
  		t.string :password
  	end
  	end
end
