class AddTimeToWeatherHours < ActiveRecord::Migration
  def change
    add_column :weather_hours, :t_time, :time
  end
end
