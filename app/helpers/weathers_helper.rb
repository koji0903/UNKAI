# coding: utf-8

module WeathersHelper


	#
	# 気象データを取得するクラス
	#   取得元：気象庁 http://www.data.jma.go.jp/gmd/risk/obsdl/index.php
	#
	#  CSV  ファイル：nkf -w -Lu --overwrite *.csv
	class ParseWheatherData
		require 'csv'
		require 'kconv'

		attr_accessor :dir, :csvFiles
		# dir : Directory that save csv file
		def initialize(dir)
			@dir = dir
			@csvFiles = nil
		end

		private
		def getCSVFile
			@csvFiles = Dir::glob(@dir + "/*.csv")
			return Dir::glob(@dir + "/*.csv")
		end

		def parse(file)
			download_time, area = nil
			header = Array.new
			data = Array.new

			File.open(file,"r:UTF-8").each_with_index do |line,i|
				line.force_encoding('UTF-8')
				elem = line.scrub('?').chomp.split(",")
				case i
				when 0
					# ダウンロードした時間
					download_time = elem[0].split("：")[1]
				when 1
					# 何もしない
				when 2
					# 地区情報
					area = elem.reject(&:empty?).uniq[0]
				when 3,4,5
					# ヘッダ情報
					header << elem
				else
					# 気象データ
					data << elem
				end
			end
			return download_time,area,header,data
		end

		# ヘッダ情報のパッキング
		def header_packing(header)
			ary = Array.new
			header[0].each_with_index do |str,i|
				str += get_str(header[1][i])
				str += get_str(header[2][i])
				ary << str
			end
			ary
		end

		def get_str(str)
			return "" if str.nil?
			(str == "") ? "" : " " + str
		end
=begin
		def data_parase(data)
			data.each do |line|
				# 日付
				date  = line[0]
			end
		end
=end
		public
		def main
			# Get CSV Files
			weather_each = Array.new
			getCSVFile.sort.each do |file|
				# それぞれのCSVファイルを読み込んでデータ分解
				download_time,area,header,data = parse(file)
#				data_parase(data)
				# 保存
				weather_each << WeatherEach.new(file,download_time,area,header_packing(header),data)
			end
			return weather_each
		end

		class WeatherEach
			attr_accessor :file_name
			attr_accessor :area, :download_time, :header, :data
			def initialize(file_name,download_time,area,header,data)
				@file_name = file_name
				@area = area
				@download_time = download_time
				@header = header
				@data = data
			end
		end
	end
end

if __FILE__ == $0
	require 'pp'
	obj = WeathersHelper::ParseWheatherData.new('../../vendor/weather_data/')
	data = obj.main
	data.each do |elem|
		p elem.area
	end
end