class Project < ActiveRecord::Base
	has_many :project_memberships
	has_many :users, :through => :project_membership
	
	validates_presence_of :title, :on => :create
end
