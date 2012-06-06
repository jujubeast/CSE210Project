class AddDeletabletoList < ActiveRecord::Migration
  def up
  	add_column :lists, :deletable, :boolean
  	List.all.each do |list|
  		list.update_attributes!(:deletable => 'true')
  	end
  end

  def down
  	remove_column :lists, :deletable
  end
end
