require 'test_helper'

class CacheudniInterfacesControllerTest < ActionController::TestCase
  setup do
    @cacheudni_interface = cacheudni_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cacheudni_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cacheudni_interface" do
    assert_difference('CacheudniInterface.count') do
      post :create, cacheudni_interface: { bps_max: @cacheudni_interface.bps_max, comment: @cacheudni_interface.comment, crecimiento: @cacheudni_interface.crecimiento, device: @cacheudni_interface.device, deviceindex: @cacheudni_interface.deviceindex, egressRate: @cacheudni_interface.egressRate, gbpsrx: @cacheudni_interface.gbpsrx, gbpstx: @cacheudni_interface.gbpstx, last_bps_max: @cacheudni_interface.last_bps_max, last_status: @cacheudni_interface.last_status, nodo: @cacheudni_interface.nodo, port: @cacheudni_interface.port, status: @cacheudni_interface.status, time: @cacheudni_interface.time }
    end

    assert_redirected_to cacheudni_interface_path(assigns(:cacheudni_interface))
  end

  test "should show cacheudni_interface" do
    get :show, id: @cacheudni_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cacheudni_interface
    assert_response :success
  end

  test "should update cacheudni_interface" do
    patch :update, id: @cacheudni_interface, cacheudni_interface: { bps_max: @cacheudni_interface.bps_max, comment: @cacheudni_interface.comment, crecimiento: @cacheudni_interface.crecimiento, device: @cacheudni_interface.device, deviceindex: @cacheudni_interface.deviceindex, egressRate: @cacheudni_interface.egressRate, gbpsrx: @cacheudni_interface.gbpsrx, gbpstx: @cacheudni_interface.gbpstx, last_bps_max: @cacheudni_interface.last_bps_max, last_status: @cacheudni_interface.last_status, nodo: @cacheudni_interface.nodo, port: @cacheudni_interface.port, status: @cacheudni_interface.status, time: @cacheudni_interface.time }
    assert_redirected_to cacheudni_interface_path(assigns(:cacheudni_interface))
  end

  test "should destroy cacheudni_interface" do
    assert_difference('CacheudniInterface.count', -1) do
      delete :destroy, id: @cacheudni_interface
    end

    assert_redirected_to cacheudni_interfaces_path
  end
end
