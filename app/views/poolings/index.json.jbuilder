json.array!(@poolings) do |pooling|
  json.extract! pooling, :id, :pool_id, :wallpaper_id
  json.url pooling_url(pooling, format: :json)
end
