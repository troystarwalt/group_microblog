class User < ActiveRecord::Base
	has_many :throws
end

class Throw < ActiveRecord::Base
	belongs_to :user
end

