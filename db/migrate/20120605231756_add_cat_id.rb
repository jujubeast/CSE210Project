class AddCatId < ActiveRecord::Migration
  def up
	add_column :tags, :category_id, :integer
  end

  def down
	remove_column :tags, :category_id
  end
end
