json.array!(@tools) do |tool|
  json.extract! tool, :id, :Hersteller, :Modell, :Barcode, :Lagerbestand, :Mindestbestand, :Anzahl_Ersatz
  json.url tool_url(tool, format: :json)
end
