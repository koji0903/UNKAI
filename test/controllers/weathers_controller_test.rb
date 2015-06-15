require 'test_helper'

class WeathersControllerTest < ActionController::TestCase
  setup do
    @weather = weathers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weathers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather" do
    assert_difference('Weather.count') do
      post :create, weather: { area: @weather.area, ave_cloud_amount: @weather.ave_cloud_amount, ave_humidity: @weather.ave_humidity, ave_pressure: @weather.ave_pressure, ave_sea_pressure: @weather.ave_sea_pressure, ave_stream_pressure: @weather.ave_stream_pressure, ave_temperature: @weather.ave_temperature, ave_wind_speed: @weather.ave_wind_speed, date: @weather.date, day_length: @weather.day_length, insolation: @weather.insolation, max_rainfall: @weather.max_rainfall, max_snow: @weather.max_snow, max_temperature: @weather.max_temperature, max_wind_direction: @weather.max_wind_direction, max_wind_speed: @weather.max_wind_speed, min_himidity: @weather.min_himidity, min_sea_pressure: @weather.min_sea_pressure, min_temperature: @weather.min_temperature, momentary_wind_direction: @weather.momentary_wind_direction, momentary_wind_speed: @weather.momentary_wind_speed, most_direction: @weather.most_direction, outline06_18: @weather.outline06_18, outline18_06: @weather.outline18_06, rainfall: @weather.rainfall, total_snow: @weather.total_snow }
    end

    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should show weather" do
    get :show, id: @weather
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather
    assert_response :success
  end

  test "should update weather" do
    patch :update, id: @weather, weather: { area: @weather.area, ave_cloud_amount: @weather.ave_cloud_amount, ave_humidity: @weather.ave_humidity, ave_pressure: @weather.ave_pressure, ave_sea_pressure: @weather.ave_sea_pressure, ave_stream_pressure: @weather.ave_stream_pressure, ave_temperature: @weather.ave_temperature, ave_wind_speed: @weather.ave_wind_speed, date: @weather.date, day_length: @weather.day_length, insolation: @weather.insolation, max_rainfall: @weather.max_rainfall, max_snow: @weather.max_snow, max_temperature: @weather.max_temperature, max_wind_direction: @weather.max_wind_direction, max_wind_speed: @weather.max_wind_speed, min_himidity: @weather.min_himidity, min_sea_pressure: @weather.min_sea_pressure, min_temperature: @weather.min_temperature, momentary_wind_direction: @weather.momentary_wind_direction, momentary_wind_speed: @weather.momentary_wind_speed, most_direction: @weather.most_direction, outline06_18: @weather.outline06_18, outline18_06: @weather.outline18_06, rainfall: @weather.rainfall, total_snow: @weather.total_snow }
    assert_redirected_to weather_path(assigns(:weather))
  end

  test "should destroy weather" do
    assert_difference('Weather.count', -1) do
      delete :destroy, id: @weather
    end

    assert_redirected_to weathers_path
  end
end
