class ProjectMembership < ActiveRecord::Base
	belongs_to :project
	belongs_to :user
	validates_presence_of :user, :on => :create
	validates_presence_of :project, :on => :create
	validates_presence_of :role
	
	before_destroy :clean_up?
	
	def clean_up?
		if self.project.project_members_count == 1
			self.project.destroy
		end
	end
	
end
