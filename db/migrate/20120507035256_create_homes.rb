class CreateHomes < ActiveRecord::Migration
  def change
    create_table :homes do |t|
      t.string :index

      t.timestamps
    end
  end
end
