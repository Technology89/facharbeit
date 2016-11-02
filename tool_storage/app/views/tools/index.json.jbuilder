json.array!(@tools) do |tool|
  json.extract! tool, :id, :hersteller, :modell, :barcode, :lagerbestand, :mindestbestand, :anzahl_ersatz
  json.url tool_url(tool, format: :json)
end
