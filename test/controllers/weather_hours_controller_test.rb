require 'test_helper'

class WeatherHoursControllerTest < ActionController::TestCase
  setup do
    @weather_hour = weather_hours(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:weather_hours)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create weather_hour" do
    assert_difference('WeatherHour.count') do
      post :create, weather_hour: {  }
    end

    assert_redirected_to weather_hour_path(assigns(:weather_hour))
  end

  test "should show weather_hour" do
    get :show, id: @weather_hour
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @weather_hour
    assert_response :success
  end

  test "should update weather_hour" do
    patch :update, id: @weather_hour, weather_hour: {  }
    assert_redirected_to weather_hour_path(assigns(:weather_hour))
  end

  test "should destroy weather_hour" do
    assert_difference('WeatherHour.count', -1) do
      delete :destroy, id: @weather_hour
    end

    assert_redirected_to weather_hours_path
  end
end
