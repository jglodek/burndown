class InvitationLink < ActiveRecord::Base
	belongs_to :project
	
	validates_presence_of :key
	validates_presence_of :project_id
	validates_uniqueness_of :key

	def generate_key
		self.key = generate_unique_key
	end
	
private

	URL_CHARS = ('0'..'9').to_a + %w(b c d f g h j k l m n p q r s t v w x y z) + %w(B C D F G H J K L M N P Q R S T V W X Y Z - _)
	URL_BASE = URL_CHARS.size

	def generate_unique_key
		shrtct = generate_shortcut
		while InvitationLink.find_by_key(shrtct) != nil
			shrtct = generate_shortcut
		end
		return shrtct
	end

	#by http://blog.kischuk.com/2008/06/23/create-tinyurl-like-urls-in-ruby/	
	def generate_shortcut
		localCount = rand(99999999999)
		result = ""
		while localCount != 0
			rem = localCount % URL_BASE
			localCount = (localCount - rem) / URL_BASE
			result = URL_CHARS[rem] + result
		end
		return result
	end
	
end
