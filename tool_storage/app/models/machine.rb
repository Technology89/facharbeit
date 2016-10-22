class Machine < ActiveRecord::Base
	has_many :indexmachines, dependent: :destroy
	validates :modell, :hersteller, presence: { message: "Bitte alle Felder ausfüllen" }
end
