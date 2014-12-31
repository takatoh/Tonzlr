json.array!(@taggings) do |tagging|
  json.extract! tagging, :id, :tag_id, :taggable_id, :taggable_type
  json.url tagging_url(tagging, format: :json)
end
