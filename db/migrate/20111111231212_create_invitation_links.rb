class CreateInvitationLinks < ActiveRecord::Migration
  def change
    create_table :invitation_links do |t|
      t.string :key
      t.integer :project_id

      t.timestamps
    end
  end
end
