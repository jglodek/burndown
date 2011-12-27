class CreateBacklogItems < ActiveRecord::Migration
  def change
    create_table :backlog_items do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :cost
      t.timestamp :finished_at

      t.timestamps
    end
  end
end
