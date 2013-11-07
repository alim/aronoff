json.array!(@macrophages) do |macrophage|
  json.extract! macrophage, :strain_name, :experiment_id, :macrophage_type, :treatment, :dose, :data, :data_type
  json.url macrophage_url(macrophage, format: :json)
end
