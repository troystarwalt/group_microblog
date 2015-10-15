class User < ActiveRecord::Base
	has_many :throws
		def isSecurePassword
		!self.password.nil? && 
		self.password.length > 8 &&
		!self.password.match("[0-9]").nil? &&
		!self.password.match("[A-Z]").nil?
	end
end

class Throw < ActiveRecord::Base
	belongs_to :user
end

