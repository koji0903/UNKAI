class WeathersController < ApplicationController
  before_action :set_weather, only: [:show, :edit, :update, :destroy]

  # GET /weathers
  # GET /weathers.json
  def index
#    @weathers = Weather.all
    @weathers = Weather.page(params[:page]).order("date")
#    @weathers = Weather.order("date")
  end

  # GET /weathers/1
  # GET /weathers/1.json
  def show
  end

  # GET /weathers/new
  def new
    @weather = Weather.new

    # CSVファイルの読み込み
    @parse_weather_data = WeathersHelper::ParseWheatherData.new("public/weather_data/monthly")
    @weather_data = @parse_weather_data.main
  end

  # GET /weathers/1/edit
  def edit
  end

  # POST /weathers
  # POST /weathers.json
  def create
#    @weather = Weather.new(weather_params)
    @parse_weather_data = WeathersHelper::ParseWheatherData.new("public/weather_data/monthly")
    @weather_data = @parse_weather_data.main

    @weather_data.each do |w|
      w.data.each do |line|
        @weather = Weather.new(
           :area => w.area,
           :date => line[0],
           :ave_temperature => line[1],
           :max_temperature => line[4],
           :min_temperature => line[7],
           :rainfall => line[10],
           :max_rainfall => line[14],
           :day_length => line[18],
           :insolation => line[22],
           :max_snow => line[25],
           :total_snow => line[29],
           :ave_wind_speed => line[33],
           :max_wind_speed => line[36],
           :max_wind_direction => line[38],
           :momentary_wind_speed => line[41],
           :momentary_wind_direction => line[43],
           :most_direction => line[46],
           :ave_stream_pressure => line[49],
           :ave_humidity => line[52],
           :min_himidity => line[55],
           :ave_pressure => line[58],
           :ave_sea_pressure => line[61],
           :min_sea_pressure => line[64],
           :ave_cloud_amount => line[68],
           :outline06_18 => line[71],
           :outline18_06 => line[74]
          )
        @weather.save
      end
    end unless @weather_data.nil?



    respond_to do |format|
      format.html { redirect_to @weather, notice: 'Weather was successfully created.' }
      format.json { render :show, status: :created, location: @weather }
=begin
        if @weather.save
          format.html { redirect_to @weather, notice: 'Weather was successfully created.' }
          format.json { render :show, status: :created, location: @weather }
        else
          format.html { render :new, notice: 'Found Same Data' }
          format.json { render json: @weather.errors, status: :unprocessable_entity }
        end
=end
      end
  end

  # PATCH/PUT /weathers/1
  # PATCH/PUT /weathers/1.json
  def update
    respond_to do |format|
      if @weather.update(weather_params)
        format.html { redirect_to @weather, notice: 'Weather was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather }
      else
        format.html { render :edit }
        format.json { render json: @weather.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weathers/1
  # DELETE /weathers/1.json
  def destroy
    @weather.destroy
    respond_to do |format|
      format.html { redirect_to weathers_url, notice: 'Weather was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather
      @weather = Weather.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_params
 #     params.require(:weather).permit(:area, :date, :ave_temperature, :max_temperature, :min_temperature, :rainfall, :max_rainfall, :day_length, :insolation, :max_snow, :total_snow, :ave_wind_speed, :max_wind_speed, :max_wind_direction, :momentary_wind_speed, :momentary_wind_direction, :most_direction, :ave_stream_pressure, :ave_humidity, :min_himidity, :ave_pressure, :ave_sea_pressure, :min_sea_pressure, :ave_cloud_amount, :outline06_18, :outline18_06)
    end
end
