class Project < ActiveRecord::Base
	attr_accessible :title, :description
	has_many :project_memberships, :dependent => :delete_all
	has_many :users, :through => :project_membership
	has_many :backlog_items, :dependent => :destroy
	
	validates_presence_of :title, :on => :create
end
