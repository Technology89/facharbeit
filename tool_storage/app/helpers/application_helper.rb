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
end
