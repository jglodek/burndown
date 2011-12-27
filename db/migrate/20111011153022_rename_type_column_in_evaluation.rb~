class RenameTypeColumnInEvaluation < ActiveRecord::Migration
  def change
		remove_column :backlog_items, :cost
		add_column :backlog_items, :evaluation_type, :integer
  end
end
