require 'test_helper'

class UnkaiPhotosControllerTest < ActionController::TestCase
  setup do
    @unkai_photo = unkai_photos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:unkai_photos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create unkai_photo" do
    assert_difference('UnkaiPhoto.count') do
      post :create, unkai_photo: { comment: @unkai_photo.comment, date: @unkai_photo.date }
    end

    assert_redirected_to unkai_photo_path(assigns(:unkai_photo))
  end

  test "should show unkai_photo" do
    get :show, id: @unkai_photo
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @unkai_photo
    assert_response :success
  end

  test "should update unkai_photo" do
    patch :update, id: @unkai_photo, unkai_photo: { comment: @unkai_photo.comment, date: @unkai_photo.date }
    assert_redirected_to unkai_photo_path(assigns(:unkai_photo))
  end

  test "should destroy unkai_photo" do
    assert_difference('UnkaiPhoto.count', -1) do
      delete :destroy, id: @unkai_photo
    end

    assert_redirected_to unkai_photos_path
  end
end
