require 'test_helper'

class CachegoogleInterfacesControllerTest < ActionController::TestCase
  setup do
    @cachegoogle_interface = cachegoogle_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cachegoogle_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cachegoogle_interface" do
    assert_difference('CachegoogleInterface.count') do
      post :create, cachegoogle_interface: { bps_max: @cachegoogle_interface.bps_max, comment: @cachegoogle_interface.comment, crecimiento: @cachegoogle_interface.crecimiento, device: @cachegoogle_interface.device, deviceindex: @cachegoogle_interface.deviceindex, egressRate: @cachegoogle_interface.egressRate, gbpsrx: @cachegoogle_interface.gbpsrx, gbpstx: @cachegoogle_interface.gbpstx, last_bps_max: @cachegoogle_interface.last_bps_max, last_status: @cachegoogle_interface.last_status, nodo: @cachegoogle_interface.nodo, port: @cachegoogle_interface.port, status: @cachegoogle_interface.status, time: @cachegoogle_interface.time }
    end

    assert_redirected_to cachegoogle_interface_path(assigns(:cachegoogle_interface))
  end

  test "should show cachegoogle_interface" do
    get :show, id: @cachegoogle_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cachegoogle_interface
    assert_response :success
  end

  test "should update cachegoogle_interface" do
    patch :update, id: @cachegoogle_interface, cachegoogle_interface: { bps_max: @cachegoogle_interface.bps_max, comment: @cachegoogle_interface.comment, crecimiento: @cachegoogle_interface.crecimiento, device: @cachegoogle_interface.device, deviceindex: @cachegoogle_interface.deviceindex, egressRate: @cachegoogle_interface.egressRate, gbpsrx: @cachegoogle_interface.gbpsrx, gbpstx: @cachegoogle_interface.gbpstx, last_bps_max: @cachegoogle_interface.last_bps_max, last_status: @cachegoogle_interface.last_status, nodo: @cachegoogle_interface.nodo, port: @cachegoogle_interface.port, status: @cachegoogle_interface.status, time: @cachegoogle_interface.time }
    assert_redirected_to cachegoogle_interface_path(assigns(:cachegoogle_interface))
  end

  test "should destroy cachegoogle_interface" do
    assert_difference('CachegoogleInterface.count', -1) do
      delete :destroy, id: @cachegoogle_interface
    end

    assert_redirected_to cachegoogle_interfaces_path
  end
end
