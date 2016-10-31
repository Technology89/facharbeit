json.array!(@machines) do |machine|
  json.extract! machine, :id, :hersteller, :modell, :barcode, :ausgegeben, :ausgegeben_am
  json.url machine_url(machine, format: :json)
end
