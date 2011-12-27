class BacklogItem < ActiveRecord::Base	
	attr_accessor :cost
	attr_accessible :title,:description, :priority, :cost

	belongs_to :project
	has_many :evaluations, :dependent => :destroy
	
	validates_numericality_of :priority, :greater_than_or_equal_to => 0, :if => Proc.new{|bi| bi.priority!=nil}
	validates_numericality_of :cost, :greater_than_or_equal_to => 0, :if => Proc.new{|bi| bi.cost!=nil && bi.cost!=""}
	validates_presence_of :title
	validates_presence_of :project_id
	
	def recent_cost
		p = Evaluation.where(:backlog_item_id => self.id, :evaluation_type => Evaluation::COST_EVALUATION).order("effective_date ASC").last
		p.value unless p==nil
	end
	
	def finished?
		Evaluation.where(:backlog_item_id => self.id, :evaluation_type => Evaluation::FINISHED).first != nil
	end
	
	def finished_at
		p = Evaluation.where(:backlog_item_id => self.id, :evaluation_type => Evaluation::FINISHED).first 
		return p.effective_date unless p==nil
	end
	
	def cost_left_at(moment)
		fa = finished_at
		if fa != nil && moment > fa 
			return 0
		end
		e = evaluations.where(:evaluation_type => Evaluation::COST_EVALUATION).where("effective_date<=?",moment).order("effective_date DESC").first
		if !e
			e = evaluations.where(:evaluation_type => Evaluation::COST_EVALUATION).where("effective_date>?",moment).order("effective_date").first
		end
		if e
			return e.value
		else
			return 0
		end
	end
	
	def authorized_owner?(user)
		self.project.authorized_owner?(user)
	end
	
	def authorized_reader?(user)
		self.project.authorized_reader?(user)
	end
end
