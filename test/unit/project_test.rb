require 'test_helper'

class ProjectTest < ActiveSupport::TestCase

	def start
		p = Project.new
		p.title = "pr"
		p.save
		b = BacklogItem.new
		b.title= "Bc"
		b.project = p
		b.save
		b
	
		timenow = Time.now

		return b
	end
	
	test "finished?" do
		b = start()
		p = b.project
		
		timenow = Time.now
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 1
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		
		p.reload
		assert p.finished? == false
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow
		assert e.save
		
		assert p.reload
		
		assert p.finished? == false
		
		p.finished_at = timenow
		
		assert p.finished? == true
		
	end
	
	
	test "finished_backlog_items" do
		b = start()
		p = b.project
		
		timenow = Time.now
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 1
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 2
		e.backlog_item = b
		e.effective_date = timenow + 1.hour
		e.save
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 3
		e.backlog_item = b
		e.effective_date = timenow + 2.hour
		e.save
		
		p.reload
		assert p.finished_backlog_items == 0
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow + 3.hour
		e.save
		
		p.reload
		assert p.finished_backlog_items == 1
		
		b2 = BacklogItem.new
		b2.project = p
		b2.title = "arrr"
		b2.save
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b2
		e.effective_date = timenow + 3.hour
		e.save
		
		p.reload
		assert p.finished_backlog_items == 2
		
	end
	
	
end
