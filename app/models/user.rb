class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
	
	has_many :project_memberships
	has_many :projects, :through => :project_memberships		
	
	validates_length_of :password, :within => 3..520, :message => "Password length should be within 3 and 520 letters long"
	validates_presence_of :email, :on => :create
	validates_presence_of :password, :on => :create
	validates_presence_of :name, :on => :create
	validates_uniqueness_of :email, :on => :create
	validates_confirmation_of :password, :message => "Password and confirmation does not match"
  validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "Invalid email format"   
end

