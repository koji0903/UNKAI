class AnalysesController < ApplicationController
	before_action :get_unkai_pre_date, only: [:home]

  def home

  	# 平均風速
  	@all_ave_wind_speed = all_Weather_ave_wind_speed
  	@unkai_ave_wind_speed = unkai_Weather_ave_wind_speed
  	@rate_ave_wind_speed = cal_rate(@all_ave_wind_speed,@unkai_ave_wind_speed)


  	# 気温差
  	@all_temperature = all_Weather_temperature
  	@unkai_temperature = unkai_Weather_temperature
 	@rate_temperature = cal_rate(@all_temperature,@unkai_temperature)

 # 	@item = unkai_Weather_temperature[1]

  	# 降水量
  	@all_rainfall = all_Weather_rainfall
  	@unkai_rainfall = unkai_Weather_rainfall
  	@rate_rainfall = cal_rate(@all_rainfall,@unkai_rainfall)


  	# 平均蒸気圧
  	@all_ave_stream_pressure = all_Weather_ave_stream_pressure
  	@unkai_ave_stream_pressure = unkai_Weather_ave_stream_pressure
  	@rate_ave_stream_pressure = cal_rate(@all_ave_stream_pressure,@unkai_ave_stream_pressure)

  	# 平均湿度
  	@all_ave_humidity = all_Weather_ave_humidity
  	@unkai_ave_humidity = unkai_Weather_ave_humidity
  	@rate_ave_humidity = cal_rate(@all_ave_humidity,@unkai_ave_humidity)

  	# 最小相対湿度
  	@all_min_humidity = all_Weather_min_humidity
  	@unkai_min_humidity = unkai_Weather_min_humidity
  	@rate_min_humidity = cal_rate(@all_min_humidity,@unkai_min_humidity)

  	# 平均現地気圧
  	@all_ave_pressure = all_Weather_ave_pressure
  	@unkai_ave_pressure = unkai_Weather_ave_pressure
  	@rate_ave_pressure = cal_rate(@all_ave_pressure,@unkai_ave_pressure)

  end

  private

  #
  # 平均風速
  #
  # 全ての日の気象情報（平均風速）を取得
  def all_Weather_ave_wind_speed
  	cal_diff_today(get_0_8_AveWindSpeed)
  end

  # 雲海出た前日の気象情報（平均風速）を取得
  def unkai_Weather_ave_wind_speed
  	# 気象情報を取得
  	cal_diff_today(get_0_8_UnkaiAveWindSpeed)
  end




  # 全ての日の気象情報（平均気温）を取得
  def all_Weather_temperature
  	cal_diff_temperature(Weather.select(:date,:max_temperature))
  end

  # 雲海出た前日の気象情報（平均気温）を取得
  def unkai_Weather_temperature
  	# 気象情報を取得
  	cal_diff_temperature(Weather.where(:date => @unkai_pre_days).select([:date,:max_temperature]))
  end

  def cal_diff_temperature(weather)
  	data = Hash.new
#  	date2 = Hash.new
	# 当日0-8時までの最低気温
  	min_data = get_0_8_MinTemp
  	weather.each do |item|
  		next if item.max_temperature.nil? || item.date.nil?
  		# 前日の最高気温
  		max_temp = item.max_temperature
  		# 前日データで計算しているので、当日に変更
  		t_date = item.date + 1
  		min_temp = min_data[t_date]
  		# 前日の最高気温　- 当日8時までの最低気温
  		temp = (max_temp - min_temp).round
  		if data.has_key?(temp) then
  			no = data[temp] + 1
  			data[temp] = no
  		else
  			data[temp] = 1
  		end
#  		date2[item.date] = [item.max_temperature,min_temp]
  	end
  	return data.sort
  end

  # 全ての日の気象情報（降水量）を取得
  def all_Weather_rainfall
  	cal_diff2(Weather.pluck(:rainfall))
  end

  # 雲海出た前日の気象情報（降水量）を取得
  def unkai_Weather_rainfall
  	# 気象情報を取得
  	cal_diff2(Weather.where(:date => @unkai_pre_days).pluck(:rainfall))
  end

  # 全ての日の気象情報（平均蒸気圧）を取得
  def all_Weather_ave_stream_pressure
  	cal_diff(Weather.pluck(:ave_stream_pressure))
  end

  # 雲海出た前日の気象情報（平均蒸気圧）を取得
  def unkai_Weather_ave_stream_pressure
  	# 気象情報を取得
  	cal_diff(Weather.where(:date => @unkai_pre_days).pluck(:ave_stream_pressure))
  end

   # 全ての日の気象情報（平均湿度）を取得
  def all_Weather_ave_humidity
  	cal_diff(Weather.pluck(:ave_humidity))
  end

  # 雲海出た前日の気象情報（平均湿度）を取得
  def unkai_Weather_ave_humidity
  	# 気象情報を取得
  	cal_diff(Weather.where(:date => @unkai_pre_days).pluck(:ave_humidity))
  end


  # 全ての日の気象情報（最小相対湿度）を取得
  def all_Weather_min_humidity
  	cal_diff(Weather.pluck(:min_himidity))
  end

  # 雲海出た前日の気象情報（最小相対湿度）を取得
  def unkai_Weather_min_humidity
  	# 気象情報を取得
  	cal_diff(Weather.where(:date => @unkai_pre_days).pluck(:min_himidity))
  end

  # 全ての日の気象情報（平均現地気圧）を取得
  def all_Weather_ave_pressure
  	cal_diff(Weather.pluck(:ave_pressure))
  end

  # 雲海出た前日の気象情報（平均現地気圧）を取得
  def unkai_Weather_ave_pressure
  	# 気象情報を取得
  	cal_diff(Weather.where(:date => @unkai_pre_days).pluck(:ave_pressure))
  end


  def cal_diff(weather,r_num=nil)
  	data = Hash.new
  	weather.each do |item|
  		next if item.nil?

  		tmp = 0
  		if r_num.nil?
	  		tmp = item.round
	  	else
	  		tmp = item.round(r_num)
	  	end

  		if data.has_key?(tmp) then
  			no = data[tmp] + 1
  			data[tmp] = no
  		else
  			data[tmp] = 1
  		end
  	end
  	data.sort
  end

  def cal_diff_today(weather,r_num=nil)
  	data = Hash.new
  	weather.each do |key,item|
  		next if item.nil?

  		tmp = 0
  		if r_num.nil?
	  		tmp = item.round
	  	else
	  		tmp = item.round(r_num)
	  	end

  		if data.has_key?(tmp) then
  			no = data[tmp] + 1
  			data[tmp] = no
  		else
  			data[tmp] = 1
  		end
  	end
  	data.sort
  end


  # ひとけた目を丸め
  def cal_diff2(weather)
  	data = Hash.new
  	weather.each do |item|
  		next if item.nil?
  		tmp = (item/10).to_i * 10
  		if data.has_key?(tmp) then
  			no = data[tmp] + 1
  			data[tmp] = no
  		else
  			data[tmp] = 1
  		end
  	end
  	data.sort
  end


  def cal_rate(all_d,unkai)
  	data = Array.new
  	all_d.each do |i|
  		value = 0
  		unkai.each do |j|
  			if i[0] == j[0]
  				value = j[1]
  				break
	  		end
  		end
  		if value == 0 || value.nil?
	  		data << [i[0].to_i,0]
	  	else
	  		data << [i[0].to_i,((value.to_f*100)/i[1].to_f).to_i]
	  	end
  	end
  	data
  end

  def get_UnkaiDays
  	# 雲海が出た日を配列で取得
  	days = UnkaiPhoto.pluck(:date).sort.uniq
  end

  def get_unkai_pre_date
  	  	# 雲海が出た日を取得
  	@unkai_pre_days = get_UnkaiDays
  	# 前日に切り替え
  	@unkai_pre_days.map!{|day| day-1 }
  end

  def get_0_8_MinTemp
  	from = Time.new(2000,1,1,0,0,0,0)
  	to = from + 8*60*60
  	WeatherHours.where(:t_time => from...to).group(:date).minimum(:temperature)
  end

  def get_0_8_AveWindSpeed
  	from = Time.new(2000,1,1,0,0,0,0)
  	to = from + 8*60*60
  	WeatherHours.where(:t_time => from...to).group(:date).average(:wind_speed)
  end

  def get_0_8_UnkaiAveWindSpeed
  	from = Time.new(2000,1,1,0,0,0,0)
  	to = from + 8*60*60
  	WeatherHours.where(:date => @unkai_pre_days, :t_time => from...to).group(:date).average(:wind_speed)
  end


end
