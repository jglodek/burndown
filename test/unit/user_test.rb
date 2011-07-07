require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
  
	$count = 1
  
  def it
  	$count = $count + 1
  	$count
  end
  
  def gen_user()
  	user = User.new
  	num = it.to_s
  	user.name = "Name" + num
  	user.password = "pass" + num
  	user.password_confirmation = "pass" + num
  	user.email = "email#{it}@email.com"
  	user
  end

	def gen_project(user)
  	num = it.to_s
		project = Project.new
		project.title = "project" + num
		project.description = "project description" + num
		assert project.save
		
		pm = ProjectMembership.new
		pm.project = project
		pm.user = user
		assert pm.save
		project
	end	

	def user_join_project(user, project)
		pm = ProjectMembership.new
		pm.project = project
		pm.user = user
		assert pm.save
		pm
	end
	 
  test "save email uniqueness" do

  	user1 = User.new
  	user1.name = "name"
  	user1.email = "email@email.com"
  	user1.password = "pass"
  	user1.password_confirmation = "pass"
  	assert user1.save
  	user2 = User.new
  	user2.name = "name"
  	user2.email = "email@email.com"
  	user2.password = "some_password"
  	user2.password_confirmation = "some_password"
  	assert !user2.save
  	
  end
  
  test "save no name" do
  	user = gen_user
  	user.name = nil
  	assert !user.save
  end
  
  test "save no email" do
  	user = gen_user
  	user.email = nil
  	assert !user.save
  end
  
  test "save no password" do
  	user = gen_user
  	user.password = nil
  	assert !user.save
  end
  
  test "save no password confirmation" do
  	user = User.new
  	user.name = "name"
  	user.email = "email@email.com"
  	user.password = "some_password"
  	user.password_confirmation = ""
  	assert !user.save
  end
  
  test "save wrong confirmation" do
  	user = gen_user
  	user.password_confirmation = "co innego"
  	assert !user.save
  end
  
  test "save wrong email format" do
  	user = gen_user
  	user.email = "zlyformat@emaila@.pl"
  	assert !user.save
  end
  
  test "save password too short" do
  	user = gen_user
  	user.password = ""
  	assert !user.save
  	user = gen_user
  	user.password = "k"
  	assert !user.save
  	user = gen_user
  	user.password = "kk"
  	assert !user.save
  	user = gen_user
  	user.password = "kkk"
  	assert !user.save
  end
  
  test "save password too long" do
  	user = gen_user
  	user.password = "kkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkkk"
  	assert !user.save
  end
  
  test "user destroy with single project" do
		user = gen_user
		user.email = "elka@eiti.pw.edu.pl"
		assert user.save
		project = gen_project(user)
		assert Project.where(:id => project.id).count !=0
		assert ProjectMembership.where(:project_id => project.id, :user_id => user.id).count !=0
		assert ProjectMembership.where(:project_id => project.id).first.role == 0
		assert user.destroy
		assert Project.where(:id => project.id).count == 0
		assert ProjectMembership.where(:project_id => project.id, :user_id => user.id).count == 0
  end


  test "user destroy other user project" do
		user = gen_user
		assert user.save
		project = gen_project(user)
		assert Project.where(:id => project.id).count ==1
		assert ProjectMembership.where(:project_id => project.id).count ==1
		user2 = gen_user
		assert assert user2.save
		user_join_project(user2,project)
		assert Project.where(:id => project.id).count ==1
		assert ProjectMembership.where(:project_id => project.id).count 
		assert user2.destroy
		assert Project.where(:id => project.id).count ==1
		assert ProjectMembership.where(:project_id => project.id).count ==1
  end

end
