require 'test_helper'

class BacklogItemTest < ActiveSupport::TestCase
	
	def start
		p = Project.new
		p.title = "pr"
		p.save
		b = BacklogItem.new
		b.title= "Bc"
		b.project = p
		b.save
		b
	end
	
	test "cost without evals" do
		b = start()
		assert b.cost_left_at(Time.now) == 0
	end
	
	test "cost with finish eval" do
		timenow = Time.now
		b = start()
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow
		e.save
	
		assert b.cost_left_at(timenow-2.hours) ==0
		assert b.cost_left_at(timenow) ==0
		assert b.cost_left_at(timenow+2.hours) ==0
	end
	
	test "cost with finish eval1" do
		timenow = Time.now
		b = start()
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 10
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		assert b.cost_left_at(timenow - 2.hours) == 10
		assert b.cost_left_at(timenow)==0
		assert b.cost_left_at(timenow+2.hours)==0
	end
	
	test "cost with finish eval2" do
		timenow = Time.now
		b = start()
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 10
		e.backlog_item = b
		e.effective_date = timenow-2.hours
		e.save
		assert b.cost_left_at(timenow - 3.hours) == 10
		assert b.cost_left_at(timenow-2.hours)==10
		assert b.cost_left_at(timenow-1.hours)==10
		assert b.cost_left_at(timenow)==0
		assert b.cost_left_at(timenow + 1.hour)==0
	end
	
	test "cost with finish eval3" do
		timenow = Time.now
		b = start()
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow
		e.save
		e = Evaluation.new
		e.evaluation_type = Evaluation::COST_EVALUATION
		e.value = 10
		e.backlog_item = b
		e.effective_date = timenow + 2.hours
		e.save
		assert b.cost_left_at(timenow - 2.hours) == 10
		assert b.cost_left_at(timenow) == 0
		assert b.cost_left_at(timenow+2.hours) == 0
	end
	
	test "cost with finish eval4" do
		timenow = Time.now
		b = start()
		
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
		
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow + 3.hour
		e.save
		
		assert b.cost_left_at(timenow- 1.hour) == 1
		assert b.cost_left_at(timenow) == 1
		assert b.cost_left_at(timenow + 15.minutes) == 1
		assert b.cost_left_at(timenow + 50.minutes) == 1
		assert b.cost_left_at(timenow + 1.hour) == 2
		assert b.cost_left_at(timenow + 1.hour + 10.minutes) == 2
		assert b.cost_left_at(timenow + 1.hour + 50.minutes) == 2
		assert b.cost_left_at(timenow + 2.hour).should == 3
		assert b.cost_left_at(timenow + 2.hour + 10.minutes) == 3
		assert b.cost_left_at(timenow + 2.hour + 50.minutes) == 3
		assert b.cost_left_at(timenow + 3.hour) == 0
		assert b.cost_left_at(timenow + 3.hour + 10.minutes) == 0
		assert b.cost_left_at(timenow + 3.hour + 50.minutes) == 0
		
	end
	
		test "cost with finish eval5" do
		timenow = Time.now
		b = start()
		
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
		
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow + 1.hour + 30.minutes
		e.save
		
		assert b.cost_left_at(timenow- 1.hour) == 1
		assert b.cost_left_at(timenow) == 1
		assert b.cost_left_at(timenow + 15.minutes) == 1
		assert b.cost_left_at(timenow + 50.minutes) == 1
		assert b.cost_left_at(timenow + 1.hour) == 2
		assert b.cost_left_at(timenow + 1.hour + 10.minutes) == 2
		assert b.cost_left_at(timenow + 1.hour + 50.minutes) == 0
		assert b.cost_left_at(timenow + 2.hour) == 0
		assert b.cost_left_at(timenow + 2.hour + 10.minutes) == 0
		assert b.cost_left_at(timenow + 2.hour + 50.minutes) == 0
		assert b.cost_left_at(timenow + 3.hour) == 0
		assert b.cost_left_at(timenow + 3.hour + 10.minutes) == 0
		assert b.cost_left_at(timenow + 3.hour + 50.minutes) == 0
	end
	
	test "recent_cost" do
				timenow = Time.now
		b = start()
		
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
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow + 1.hour + 30.minutes
		e.save

		assert b.recent_cost()== 3
	end
	
	
	test "finished" do
		timenow = Time.now
		b = start()
		
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
		
		assert b.finished? ==false
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		e.effective_date = timenow + 1.hour + 30.minutes
		e.save

		assert b.finished? ==true
	end
	
	test "finished_at" do
		timenow = Time.now
		b = start()
		
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
		
		assert b.finished? ==false
		
		e = Evaluation.new
		e.evaluation_type = Evaluation::FINISHED
		e.backlog_item = b
		t = timenow + 1.hour + 30.minutes
		e.effective_date = t
		e.save
		
		assert (b.finished_at.to_i == t.to_i)
		
	end
	test "finished_at nil" do
		timenow = Time.now
		b = start()
		
		assert b.finished_at == nil
	end
	
	
end