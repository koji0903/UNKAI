json.array!(@unkai_photos) do |unkai_photo|
  json.extract! unkai_photo, :id, :comment, :date
  json.url unkai_photo_url(unkai_photo, format: :json)
end
