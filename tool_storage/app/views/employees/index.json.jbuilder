json.array!(@employees) do |employee|
  json.extract! employee, :id, :Vorname, :Nachname, :Personalnummer
  json.url employee_url(employee, format: :json)
end
