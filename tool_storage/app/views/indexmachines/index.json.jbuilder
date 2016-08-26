json.array!(@indexmachines) do |indexmachine|
  json.extract! indexmachine, :id, :ausgeliehen, :ausgeliehen_am, :employee_id, :machine_id
  json.url indexmachine_url(indexmachine, format: :json)
end
