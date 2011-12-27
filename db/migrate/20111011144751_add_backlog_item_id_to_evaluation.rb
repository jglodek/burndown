class AddBacklogItemIdToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :backlog_item_id, :integer
  end
end
