class AddingForeignKeys < ActiveRecord::Migration
  def change
  	change_table :project_memberships do |t|
  		t.integer :user_id
  		t.integer :project_id
  	end
  end
end
