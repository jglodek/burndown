class Evaluation < ActiveRecord::Base
	attr_accessible :evaluation_type, :effective_date, :value
	belongs_to :backlog_item
	
	COST_EVALUATION = 0
	FINISHED = 1
	
	validates :backlog_item_id, :presence => true
	validates :evaluation_type, :presence => true
	validates :effective_date, :presence => true
	validates_presence_of :value, :if => Proc.new {|ev| ev.evaluation_type==COST_EVALUATION}
	validates_numericality_of :value, :greater_than_or_equal_to => 0, :if => Proc.new {|ev| ev.evaluation_type==COST_EVALUATION}
	
	def authorized_owner?(user)
		self.backlog_item.project.authorized_owner? user
	end
	
end
