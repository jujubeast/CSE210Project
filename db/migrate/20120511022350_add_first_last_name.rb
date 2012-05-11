class AddFirstLastName < ActiveRecord::Migration
  def up
  	 change_table :users do |t|
      t.string :first_ame
      t.string :last_name
      t.timestamps
    end

  end

  def down
  end
end
