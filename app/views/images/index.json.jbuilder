json.array!(@images) do |image|
  json.extract! image, :id, :wallpaper_id, :width, :height, :path
  json.url image_url(image, format: :json)
end
