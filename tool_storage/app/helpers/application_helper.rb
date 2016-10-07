module ApplicationHelper
	def bool_to_german(var)
		if var == true
			"Ja"
		else
			"Nein"
		end
	end

	def full_name(var)
		var.vorname + " " + var.nachname
	end

	def full_name_with_nr(var)
		var.vorname + " " + var.nachname + " " + var.personalnummer.to_s
	end
end
