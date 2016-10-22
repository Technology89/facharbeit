class Employee < ActiveRecord::Base
	has_many :indexmachines, dependent: :destroy
	has_many :indextools, dependent: :destroy
	validates :vorname, :nachname, :personalnummer, presence: { message: "Bitte alle Felder ausfüllen" }
	validates :personalnummer, uniqueness: { message: "Personalnummer bereits vergeben" }
	

	def self.setup(personalnummer)
  	employee = Employee.find_by(personalnummer: personalnummer)
  end
	
end
