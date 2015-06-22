class AnalysesController < ApplicationController
  def home
  	weather = Weather.all
  	data = Hash.new
  	weather.each do |item|
  		temp = (item.max_temperature - item.min_temperature).round
  		if data.has_key?(temp) then
  			no = data[temp] + 1
  			data[temp] = no
  		else
  			data[temp] = 1
  		end
  	end
  	@graph_data = data.sort
  end
end
