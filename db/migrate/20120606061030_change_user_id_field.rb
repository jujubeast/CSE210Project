class ChangeUserIdField < ActiveRecord::Migration
  def up
	add_column :tags, :user_id, :integer
  end

  def down
  end
end
