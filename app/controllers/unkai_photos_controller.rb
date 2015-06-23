class UnkaiPhotosController < ApplicationController
  before_action :set_unkai_photo, only: [:show, :edit, :update, :destroy]

  # GET /unkai_photos
  # GET /unkai_photos.json
  def index
#    @unkai_photos = UnkaiPhoto.all
    @unkai_photos = UnkaiPhoto.page(params[:page]).order("date")
#    sql = "select u.date as date, u.comment, u.id, u.image, u.created_at as created_at from unkai_photos as u left join weathers as w1 on ( u.date = w1.date ) left join weathers as w2 on ( date(u.date, '-1 days') = w2.date )"
#    @unkai_photos = UnkaiPhoto.find_by_sql(sql)
  end

  # GET /unkai_photos/1
  # GET /unkai_photos/1.json
  def show

    # 前日と、当日のHourly気象情報を取得（グラフ表示）
    unkai_photo_hourly = get_HourlyReport

    # 気温
    @temperature = Array.new
    unkai_photo_hourly.each do |item|
      @temperature << [item.date_time.to_s.sub('UTC','+0900'),item.temperature]
    end
    # 風速
    @wind_speed = Array.new
    unkai_photo_hourly.each do |item|
      @wind_speed << [item.date_time.to_s.sub('UTC','+0900'),item.wind_speed]
    end
    # 雨量
    @railfall = Array.new
    unkai_photo_hourly.each do |item|
      @railfall << [item.date_time.to_s.sub('UTC','+0900'),item.railfall]
    end
    # 現地気圧
    @pressure = Array.new
    unkai_photo_hourly.each do |item|
      @pressure << [item.date_time.to_s.sub('UTC','+0900'),item.pressure]
    end
    # 湿度
    @humidity = Array.new
    unkai_photo_hourly.each do |item|
      @humidity << [item.date_time.to_s.sub('UTC','+0900'),item.humidity]
    end
    # 蒸気圧
    @stream_pressure = Array.new
    unkai_photo_hourly.each do |item|
      @stream_pressure << [item.date_time.to_s.sub('UTC','+0900'),item.stream_pressure]
    end


    # 前日と、当日のDaily気象情報を取得（テーブル表示）
    @unkai_photo = get_TodayYesterDayDayilyReport


  end

  # GET /unkai_photos/new
  def new
    @unkai_photo = UnkaiPhoto.new
  end

  # GET /unkai_photos/1/edit
  def edit
  end

  # POST /unkai_photos
  # POST /unkai_photos.json
  def create
    @unkai_photo = UnkaiPhoto.new(unkai_photo_params)

    respond_to do |format|
      if @unkai_photo.save
        format.html { redirect_to @unkai_photo, notice: 'Unkai photo was successfully created.' }
        format.json { render :show, status: :created, location: @unkai_photo }
      else
        format.html { render :new }
        format.json { render json: @unkai_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /unkai_photos/1
  # PATCH/PUT /unkai_photos/1.json
  def update
    respond_to do |format|
      if @unkai_photo.update(unkai_photo_params)
        format.html { redirect_to @unkai_photo, notice: 'Unkai photo was successfully updated.' }
        format.json { render :show, status: :ok, location: @unkai_photo }
      else
        format.html { render :edit }
        format.json { render json: @unkai_photo.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /unkai_photos/1
  # DELETE /unkai_photos/1.json
  def destroy
    @unkai_photo.destroy
    respond_to do |format|
      format.html { redirect_to unkai_photos_url, notice: 'Unkai photo was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_unkai_photo
      @unkai_photo = UnkaiPhoto.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def unkai_photo_params
      params.require(:unkai_photo).permit(:image, :image_cache, :remove_image, :comment, :date)
    end

    def get_TodayYesterDayDayilyReport
      sql = "select "
      sql += " u.id, u.comment, u.date, u.image as image,"

      sql += " w1.area as t_area, w1.date as t_date, w1.ave_temperature as t_ave_temperature, "
      sql += " w1.max_temperature as t_max_temperature, w1.min_temperature as t_min_temperature, w1.rainfall as t_rainfall, w1.max_rainfall as t_max_rainfall, "
      sql += " w1.day_length as t_day_length, w1.insolation as t_insolation, w1.max_snow as t_max_snow, w1.total_snow as t_total_snow,"
      sql += " w1.ave_wind_speed as t_ave_wind_speed, w1.max_wind_speed as t_max_wind_speed, w1.max_wind_direction as t_max_wind_direction,"
      sql += " w1.momentary_wind_speed as t_momentary_wind_speed, w1.momentary_wind_direction as t_momentary_wind_direction, w1.most_direction as t_most_direction,"
      sql += " w1.ave_stream_pressure as t_ave_stream_pressure, w1.ave_humidity as t_ave_humidity, w1.min_himidity as t_min_himidity, w1.ave_pressure as t_ave_pressure,"
      sql += " w1.ave_sea_pressure as t_ave_sea_pressure, w1.min_sea_pressure as t_min_sea_pressure, w1.ave_cloud_amount as t_ave_cloud_amount, w1.outline06_18 as t_outline06_18, w1.outline18_06 as t_outline18_06"
      sql += ","
      sql += " w2.area as y_area, w2.date as y_date, w2.ave_temperature as y_ave_temperature, "
      sql += " w2.max_temperature as y_max_temperature, w2.min_temperature as y_min_temperature, w2.rainfall as y_rainfall, w2.max_rainfall as y_max_rainfall, "
      sql += " w2.day_length as y_day_length, w2.insolation as y_insolation, w2.max_snow as y_max_snow, w2.total_snow as y_total_snow,"
      sql += " w2.ave_wind_speed as y_ave_wind_speed, w2.max_wind_speed as y_max_wind_speed, w2.max_wind_direction as y_max_wind_direction,"
      sql += " w2.momentary_wind_speed as y_momentary_wind_speed, w2.momentary_wind_direction as y_momentary_wind_direction, w2.most_direction as y_most_direction,"
      sql += " w2.ave_stream_pressure as y_ave_stream_pressure, w2.ave_humidity as y_ave_humidity, w2.min_himidity as y_min_himidity, w2.ave_pressure as y_ave_pressure,"
      sql += " w2.ave_sea_pressure as y_ave_sea_pressure, w2.min_sea_pressure as y_min_sea_pressure, w2.ave_cloud_amount as y_ave_cloud_amount, w2.outline06_18 as y_outline06_18, w2.outline18_06 as y_outline18_06"

      sql += " from unkai_photos as u "
      sql += " left join weathers as w1 on ( u.date = w1.date ) "
      sql += " left join weathers as w2 on ( date(u.date, '-1 days') = w2.date ) "
      sql += " where u.id = :id LIMIT 1"
      id = params[:id]
      tmp = UnkaiPhoto.find_by_sql([sql,{id: id}])
      @unkai_photo = tmp[0]

      @unkai_photo
    end

    def get_HourlyReport
      id = params[:id]
      date = UnkaiPhoto.find_by(id: id).date
      return WeatherHour.where( date: [date-1,date] ).order('date, date_time').limit(34)
    end

    def get_param_date(param)
      @item = Array.new
      unkai_photo_hourly.each do |item|
        #tmp = item.#{param}
        tmp = "0"
        @item << [item.date_time.to_s.sub('UTC','+0900'),tmp]
      end
    end
end
