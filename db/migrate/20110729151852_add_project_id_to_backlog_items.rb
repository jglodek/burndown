class AddProjectIdToBacklogItems < ActiveRecord::Migration
  def change
    add_column :backlog_items, :project_id, :integer
  end
end
