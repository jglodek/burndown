class RemoveCostFromBacklogItem < ActiveRecord::Migration
  def change
		 remove_column :backlog_items, :cost
		 remove_column :backlog_items, :finished_at
	end
end
