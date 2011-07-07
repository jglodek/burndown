class ProjectDescriptionsStringToText < ActiveRecord::Migration
  def change
		remove_column :projects, :description
		add_column :projects, :description, :text
  end
end
