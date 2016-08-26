json.array!(@machines) do |machine|
  json.extract! machine, :id, :Hersteller, :Modell, :Barcode, :Ausgeliegen, :Ausgeliehen_seit
  json.url machine_url(machine, format: :json)
end
