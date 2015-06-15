# coding: utf-8

#
# 気象データを取得するクラス
#   取得元：気象庁 http://www.data.jma.go.jp/gmd/risk/obsdl/index.php
#
#  CSV  ファイル：nkf -w -Lu --overwrite *.csv


require 'pp'
require 'csv'

class ParseWheatherData

	# dir : Directory that save csv file
	def initialize(dir)
		@dir = dir
		@csvFiles = nil
	end

	private
	def getCSVFile
		return Dir::glob(@dir + "/*.csv")
	end

	def parse(file)
		download_time, area = nil
		header = Array.new
		data = Array.new
		CSV.open(file, 'r:utf-8').each_with_index do |line,i|
			case i
			when 0
				# ダウンロード時間
				download_time = line[0].split("：")[1]
			when 1
				# 何もしない
			when 2
				# 地区情報
				area = line.compact.uniq[0]
			when 3,4,5
				# ヘッダ情報
				header << line
			else
				# 気象データ
				data << line
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
		str.nil? ? "" : " " + str
	end

	def data_parase(data)
		data.each do |line|
			# 日付
			date  = line[0]
			p date
		end
	end

	public
	def main
		# Get CSV Files
		getCSVFile.sort.each do |file|
			# それぞれのCSVファイルを読み込んでデータ分解
			download_time,area,header,data = parse(file)
			data_parase(data)
		end
	end
end

if __FILE__ == $0
	dir = "../data"
	wheatehr = ParseWheatherData.new(dir)
	wheatehr.main
end
