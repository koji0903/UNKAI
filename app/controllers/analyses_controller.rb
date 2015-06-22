class AnalysesController < ApplicationController
	before_action :get_unkai_pre_date, only: [:home]

  def home

  	# 気温差
  	@all_temperature = all_Weather_temperature
  	@unkai_temperature = unkai_Weather_temperature

  	# 湿度
  	@all_ave_humidity = all_Weather_ave_humidity
  	@unkai_ave_humidity = unkai_Weather_ave_humidity
  end

  private
  # 全ての日の気象情報（平均気温）を取得
  def all_Weather_temperature
  	cal_diff_temperature(Weather.select([:max_temperature,:min_temperature]))
  end

  # 雲海出た前日の気象情報（平均気温）を取得
  def unkai_Weather_temperature
  	# 気象情報を取得
  	cal_diff_temperature(Weather.where(:date => @unkai_pre_days).select([:max_temperature,:min_temperature]))
  end

  def cal_diff_temperature(weather)
  	data = Hash.new
  	weather.each do |item|
  		next if item.max_temperature.nil? || item.min_temperature.nil?
  		temp = (item.max_temperature - item.min_temperature).round
  		if data.has_key?(temp) then
  			no = data[temp] + 1
  			data[temp] = no
  		else
  			data[temp] = 1
  		end
  	end
  	data.sort
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

  def cal_diff(weather)
  	data = Hash.new
  	weather.each do |item|
  		next if item.nil?
  		tmp = item.round
  		if data.has_key?(tmp) then
  			no = data[tmp] + 1
  			data[tmp] = no
  		else
  			data[tmp] = 1
  		end
  	end
  	data.sort
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
end
