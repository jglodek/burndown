module ProjectsHelper	

	def series_to_chart_data(series)
		a = Array.new
		series.each do |row|
			point_name = ""
			if row[2]
					row[2].each do |e| 
					type_text = ""
					case e.evaluation_type
					when Evaluation::FINISHED
						type_text = "finished"
					when Evaluation::COST_EVALUATION
						type_text = "evaluated"
					end
					point_name+="'#{e.backlog_item.title}' #{ type_text } at #{e.effective_date.hour}:#{e.effective_date.min}<br>"
				end
			end
			h = Hash.new
			h[:x] = row[0].to_i*1000
			h[:y] = row[1]
			h[:name] = point_name
			a.push h
		end
		a.to_json
	end
	
end
