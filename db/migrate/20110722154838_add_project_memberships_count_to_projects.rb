class AddProjectMembershipsCountToProjects < ActiveRecord::Migration
  def change
    add_column :projects, :project_memberships_count, :integer
  end
end
