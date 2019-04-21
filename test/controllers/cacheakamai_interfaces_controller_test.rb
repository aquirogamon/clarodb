require 'test_helper'

class CacheakamaiInterfacesControllerTest < ActionController::TestCase
  setup do
    @cacheakamai_interface = cacheakamai_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cacheakamai_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cacheakamai_interface" do
    assert_difference('CacheakamaiInterface.count') do
      post :create, cacheakamai_interface: { bps_max: @cacheakamai_interface.bps_max, comment: @cacheakamai_interface.comment, crecimiento: @cacheakamai_interface.crecimiento, device: @cacheakamai_interface.device, deviceindex: @cacheakamai_interface.deviceindex, egressRate: @cacheakamai_interface.egressRate, gbpsrx: @cacheakamai_interface.gbpsrx, gbpstx: @cacheakamai_interface.gbpstx, last_bps_max: @cacheakamai_interface.last_bps_max, last_status: @cacheakamai_interface.last_status, nodo: @cacheakamai_interface.nodo, port: @cacheakamai_interface.port, status: @cacheakamai_interface.status, time: @cacheakamai_interface.time }
    end

    assert_redirected_to cacheakamai_interface_path(assigns(:cacheakamai_interface))
  end

  test "should show cacheakamai_interface" do
    get :show, id: @cacheakamai_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cacheakamai_interface
    assert_response :success
  end

  test "should update cacheakamai_interface" do
    patch :update, id: @cacheakamai_interface, cacheakamai_interface: { bps_max: @cacheakamai_interface.bps_max, comment: @cacheakamai_interface.comment, crecimiento: @cacheakamai_interface.crecimiento, device: @cacheakamai_interface.device, deviceindex: @cacheakamai_interface.deviceindex, egressRate: @cacheakamai_interface.egressRate, gbpsrx: @cacheakamai_interface.gbpsrx, gbpstx: @cacheakamai_interface.gbpstx, last_bps_max: @cacheakamai_interface.last_bps_max, last_status: @cacheakamai_interface.last_status, nodo: @cacheakamai_interface.nodo, port: @cacheakamai_interface.port, status: @cacheakamai_interface.status, time: @cacheakamai_interface.time }
    assert_redirected_to cacheakamai_interface_path(assigns(:cacheakamai_interface))
  end

  test "should destroy cacheakamai_interface" do
    assert_difference('CacheakamaiInterface.count', -1) do
      delete :destroy, id: @cacheakamai_interface
    end

    assert_redirected_to cacheakamai_interfaces_path
  end
end
