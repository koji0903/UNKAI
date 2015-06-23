json.array!(@weather_hours) do |weather_hour|
  json.extract! weather_hour, :id
  json.url weather_hour_url(weather_hour, format: :json)
end
