class Project < ActiveRecord::Base
	attr_accessible :title, :description
	has_many :project_memberships, :dependent => :delete_all
	has_many :users, :through => :project_membership
	has_many :backlog_items, :dependent => :destroy
	has_many :evaluations, :through => :backlog_items
	has_many :invitation_links
	
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
	
	#taf stuff
	def series
		dates_sums = Hash.new
		dates_evals = Hash.new
		evals = evaluations.order("effective_date")
		
		#tabela z wynikami
		series = Array.new
		
		#dane poczatkowe
		evals.each do |e|
			t = e.effective_date + 3.hours
			td = Time.new(t.year, t.month,t.day,t.hour)
			dates_sums[td] = 0
			dates_evals[td] ||= Array.new
			dates_evals[td].push e
		end
		
		#obliczamy sumy dla każdej daty
		dates_sums.each do |date, sum|
			backlog_items.each do |bc|
				dates_sums[date] += bc.cost_left_at date
			end
		end
		
		#tworzenie par x y
		dates_sums.each do |date, sum|
			series.push [date, sum, dates_evals[date]]
		end
		#dodajemy dzisiejszą datę
		series.push [Time.now,self.cost_points - self.cost_points_finished, nil]
		
		series
	end
	
	
	
end
