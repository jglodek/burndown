class CreateEvaluations < ActiveRecord::Migration
  def change
    create_table :evaluations do |t|
      t.integer :value
      t.datetime :effective_date

      t.timestamps
    end
  end
end
