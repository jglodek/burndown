class ProjectMembership < ActiveRecord::Base
	belongs_to :project
	belongs_to :user
	validates_presence_of :user, :on => :create
	validates_presence_of :project, :on => :create
	
	
end
