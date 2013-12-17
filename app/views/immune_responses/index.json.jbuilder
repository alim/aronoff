json.array!(@immune_responses) do |immune_response|
  json.extract! immune_response, :experiment_id, :strain_name, :cell_type, :model, :compartment, :time_point, :moi, :strain_status, :treatment, :units
  json.url immune_response_url(immune_response, format: :json)
end
