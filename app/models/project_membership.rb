class ProjectMembership < ActiveRecord::Base
	belongs_to :project,  :counter_cache => true
	belongs_to :user
	validates_presence_of :user, :on => :create
	validates_presence_of :project, :on => :create
	validates_presence_of :role
	
	before_destroy :clean_up?
	
	def clean_up?
		if self.project.project_memberships.count == 1
			self.project.destroy
		end
	end
	
	OWNER = 0
	VISITOR = 1
	NONE = 2
	
end
