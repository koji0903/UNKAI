json.array!(@weathers) do |weather|
  json.extract! weather, :id, :area, :date, :ave_temperature, :max_temperature, :min_temperature, :rainfall, :max_rainfall, :day_length, :insolation, :max_snow, :total_snow, :ave_wind_speed, :max_wind_speed, :max_wind_direction, :momentary_wind_speed, :momentary_wind_direction, :most_direction, :ave_stream_pressure, :ave_humidity, :min_himidity, :ave_pressure, :ave_sea_pressure, :min_sea_pressure, :ave_cloud_amount, :outline06_18, :outline18_06
  json.url weather_url(weather, format: :json)
end
