class Employee < ActiveRecord::Base
	has_many :indexmachines
	has_many :indextools

	def self.setup(personalnummer)
  	employee = Employee.find_by(personalnummer: personalnummer)
  end
	
end
