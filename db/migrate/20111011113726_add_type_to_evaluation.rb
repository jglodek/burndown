class AddTypeToEvaluation < ActiveRecord::Migration
  def change
    add_column :evaluations, :type, :integer
  end
end
