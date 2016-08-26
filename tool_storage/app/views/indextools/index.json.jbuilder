json.array!(@indextools) do |indextool|
  json.extract! indextool, :id, :ausgeliehen, :ausgeliehen_am, :employee_id, :tool_id
  json.url indextool_url(indextool, format: :json)
end
