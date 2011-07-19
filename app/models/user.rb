class User < ActiveRecord::Base
	attr_accessible :email, :password, :password_confirmation, :name
	has_secure_password
	
	before_destroy :clean_up
	
	def clean_up
		project_memberships.destroy_all()		
	end
	
	has_many :project_memberships
	has_many :projects, :through => :project_memberships		
	
	validates_length_of :password,:if => :password_digest_changed?, :within => 4..520, :message => "length should be within 3 and 520 letters long"
	validates_presence_of :password, :if => :password_digest_changed?
	validates_presence_of :email 
	validates_presence_of :name
	validates_uniqueness_of :email
	validates_format_of :email, :with => /^([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})$/i, :message => "has invalid format"	
end
