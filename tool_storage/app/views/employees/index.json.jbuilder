json.array!(@employees) do |employee|
  json.extract! employee, :id, :vorname, :nachname, :personalnummer
  json.url employee_url(employee, format: :json)
end
