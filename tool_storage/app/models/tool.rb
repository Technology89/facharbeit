class Tool < ActiveRecord::Base
	has_many :indextools, dependent: :destroy

	validates :modell, :hersteller, :lagerbestand, :mindestbestand, presence: { message: "Bitte alle Felder ausfüllen" }
	validates :hersteller, uniqueness: { scope: :modell,
    message: "Das Modell des Herstellers ist bereits hinterlegt" }
end
