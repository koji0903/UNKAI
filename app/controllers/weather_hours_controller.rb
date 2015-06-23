class WeatherHoursController < ApplicationController
  before_action :set_weather_hour, only: [:show, :edit, :update, :destroy]

  # GET /weather_hours
  # GET /weather_hours.json
  def index
    @q = WeatherHour.search(params[:q])
    @weather_hours = @q.result.page(params[:page])
  end

  # GET /weather_hours/1
  # GET /weather_hours/1.json
  def show
  end

  # GET /weather_hours/new
  def new
    @weather_hour = WeatherHour.new
  end

  # GET /weather_hours/1/edit
  def edit
  end

  # POST /weather_hours
  # POST /weather_hours.json
  def create
    @weather_hour = WeatherHour.new(weather_hour_params)

    respond_to do |format|
      if @weather_hour.save
        format.html { redirect_to @weather_hour, notice: 'Weather hour was successfully created.' }
        format.json { render :show, status: :created, location: @weather_hour }
      else
        format.html { render :new }
        format.json { render json: @weather_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /weather_hours/1
  # PATCH/PUT /weather_hours/1.json
  def update
    respond_to do |format|
      if @weather_hour.update(weather_hour_params)
        format.html { redirect_to @weather_hour, notice: 'Weather hour was successfully updated.' }
        format.json { render :show, status: :ok, location: @weather_hour }
      else
        format.html { render :edit }
        format.json { render json: @weather_hour.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /weather_hours/1
  # DELETE /weather_hours/1.json
  def destroy
    @weather_hour.destroy
    respond_to do |format|
      format.html { redirect_to weather_hours_url, notice: 'Weather hour was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_weather_hour
      @weather_hour = WeatherHours.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def weather_hour_params
      params[:weather_hour]
    end
end
