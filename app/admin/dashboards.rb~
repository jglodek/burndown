ActiveAdmin::Dashboards.build do

  # Define your dashboard sections here. Each block will be
  # rendered on the dashboard in the context of the view. So just
  # return the content which you would like to display.
  
	section 'Most active users' do
		
		table_for User.all do |user|
			
			column :email do |user|
				link_to(user.email, admin_user_path(user))
			end
			
			column :project_memberships_count, :sortable => true do |user|
				user.project_memberships.count.to_s
			end
			
			column :projects_count, :sortable => true do |user|
				user.projects.count.to_s
			end
			
			column :backlog_items_count, :sortable => true do |user|
				bi_c =0
				user.projects.each do |proj|
					bi_c += proj.backlog_items.count
				end
				bi_c.to_s
			end
			
			column :evaluations_count, :sortable => true do |user|
				eval_c = 0
				user.projects.each do |proj|
					proj.backlog_items.each do |bi|
						eval_c += bi.evaluations.count
					end
				end
				eval_c.to_s
			end
			
    end
    strong { link_to "View All Users", admin_users_path }
	end
	
  # == Simple Dashboard Section
  # Here is an example of a simple dashboard section
  #
  #   section "Recent Posts" do
  #     ul do
  #       Post.recent(5).collect do |post|
  #         li link_to(post.title, admin_post_path(post))
  #       end
  #     end
  #   end
  
  # == Render Partial Section
  # The block is rendered within the context of the view, so you can
  # easily render a partial rather than build content in ruby.
  #
  #   section "Recent Posts" do
  #     div do
  #       render 'recent_posts' # => this will render /app/views/admin/dashboard/_recent_posts.html.erb
  #     end
  #   end
  
  # == Section Ordering
  # The dashboard sections are ordered by a given priority from top left to
  # bottom right. The default priority is 10. By giving a section numerically lower
  # priority it will be sorted higher. For example:
  #
  #   section "Recent Posts", :priority => 10
  #   section "Recent User", :priority => 1
  #
  # Will render the "Recent Users" then the "Recent Posts" sections on the dashboard.

end
