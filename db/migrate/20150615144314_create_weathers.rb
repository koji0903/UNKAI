class CreateWeathers < ActiveRecord::Migration
  def change
    create_table :weathers do |t|
      t.string :area
      t.date :date
      t.float :ave_temperature
      t.float :max_temperature
      t.float :min_temperature
      t.float :rainfall
      t.float :max_rainfall
      t.float :day_length
      t.float :insolation
      t.float :max_snow
      t.float :total_snow
      t.float :ave_wind_speed
      t.float :max_wind_speed
      t.string :max_wind_direction
      t.float :momentary_wind_speed
      t.string :momentary_wind_direction
      t.string :most_direction
      t.float :ave_stream_pressure
      t.integer :ave_humidity
      t.integer :min_himidity
      t.float :ave_pressure
      t.float :ave_sea_pressure
      t.float :min_sea_pressure
      t.float :ave_cloud_amount
      t.text :outline06_18
      t.text :outline18_06

      t.timestamps null: false
    end
  end
end
