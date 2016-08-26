class Employee < ActiveRecord::Base
	has_many :indexmachines
	has_many :indextools

	def self.authenticate(personalnummer)
  	employee = Employee.find_by(personalnummer)
  end
	
end
