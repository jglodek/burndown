class CreateProjectMemberships < ActiveRecord::Migration
  def change
    create_table :project_memberships do |t|
      t.integer :role

      t.timestamps
    end
  end
end
