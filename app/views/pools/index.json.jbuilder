json.array!(@pools) do |pool|
  json.extract! pool, :id, :name, :description, :poolings_count, :closed
  json.url pool_url(pool, format: :json)
end
