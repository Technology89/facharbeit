class User < ActiveRecord::Base
	has_secure_password

	def self.authenticate(name, password)
  	user = User.find_by(name: name)
  	user && user.authenticate(password)
  end
end
