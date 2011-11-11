class Project < ActiveRecord::Base
	attr_accessible :title, :description
	has_many :project_memberships, :dependent => :delete_all
	has_many :users, :through => :project_membership
	has_many :backlog_items, :dependent => :destroy
	
	validates_presence_of :title, :on => :create
	
	
	def finished?
		finished_at != nil
	end
	
	def finished_backlog_items
		a=0
		backlog_items.each do |bi|
			a+=1 unless !bi.finished?
		end
		return a
	end
	
	def cost_points_finished
		a=0
		backlog_items.each do |bi|
			a+=bi.recent_cost if bi.finished?
		end
		return a
	end
	
	def cost_points
		a=0
		backlog_items.each do |bi|
			a+=bi.recent_cost if bi.recent_cost
		end
		return a
	end
	
	def owners_membership
		ProjectMembership.where(:project_id => self.id, :role => ProjectMembership::OWNER).first
	end
	
	def users_membership(user)
		ProjectMembership.where(:project_id => self.id, :user_id => user.id).first
	end
	
	def authorized_owner?(user)
		um = users_membership(user)
		if um!= nil
			um.role == ProjectMembership::OWNER
		else
			false
		end
	end
	
	def authorized_reader?(user)
		if authorized_owner?(user)
			return true
		else
			um = users_membership(user)
			return um.role == ProjectMembership::VISITOR unless um==nil
		end
		false
	end	
end
