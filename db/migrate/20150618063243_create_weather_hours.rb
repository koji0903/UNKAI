class CreateWeatherHours < ActiveRecord::Migration
  def change
    create_table :weather_hours do |t|
      t.string :area, :null => false
      t.date :date, :null => false
      t.datetime :date_time, :null => false
      t.float :temperature
      t.float :wind_speed
      t.string :wind_direction
      t.float :railfall
      t.float :snow
      t.float :day_length
      t.float :insolation
      t.float :pressure
      t.float :sea_pressure
      t.integer :humidity
      t.float :stream_pressure

      t.timestamps null: false

      t.index [:area, :date, :date_time], :unique => true
    end
  end
end
