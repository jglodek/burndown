class RefactoringBacklogItemsAndEvaluations < ActiveRecord::Migration
  def change
		remove_column :backlog_items, :evaluation_type
		add_column :evaluations, :evaluation_type, :integer
		remove_column :evaluations, :type
	end
end
