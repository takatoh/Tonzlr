json.array!(@wallpapers) do |wallpaper|
  json.extract! wallpaper, :id, :title, :series, :creator, :source, :thumbnail_path, :sample_path
  json.url wallpaper_url(wallpaper, format: :json)
end
