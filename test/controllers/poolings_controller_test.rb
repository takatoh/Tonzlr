require 'test_helper'

class PoolingsControllerTest < ActionController::TestCase
  setup do
    @pooling = poolings(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:poolings)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create pooling" do
    assert_difference('Pooling.count') do
      post :create, pooling: { pool_id: @pooling.pool_id, wallpaper_id: @pooling.wallpaper_id }
    end

    assert_redirected_to pooling_path(assigns(:pooling))
  end

  test "should show pooling" do
    get :show, id: @pooling
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @pooling
    assert_response :success
  end

  test "should update pooling" do
    patch :update, id: @pooling, pooling: { pool_id: @pooling.pool_id, wallpaper_id: @pooling.wallpaper_id }
    assert_redirected_to pooling_path(assigns(:pooling))
  end

  test "should destroy pooling" do
    assert_difference('Pooling.count', -1) do
      delete :destroy, id: @pooling
    end

    assert_redirected_to poolings_path
  end
end
