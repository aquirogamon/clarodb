require 'test_helper'

class RedcorporativaInterfacesControllerTest < ActionController::TestCase
  setup do
    @redcorporativa_interface = redcorporativa_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:redcorporativa_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create redcorporativa_interface" do
    assert_difference('RedcorporativaInterface.count') do
      post :create, redcorporativa_interface: { bps_max: @redcorporativa_interface.bps_max, comment: @redcorporativa_interface.comment, crecimiento_rx: @redcorporativa_interface.crecimiento_rx, crecimiento_tx: @redcorporativa_interface.crecimiento_tx, device: @redcorporativa_interface.device, deviceindex: @redcorporativa_interface.deviceindex, egressRate: @redcorporativa_interface.egressRate, gbpsrx: @redcorporativa_interface.gbpsrx, gbpstx: @redcorporativa_interface.gbpstx, last_bps_max: @redcorporativa_interface.last_bps_max, last_status: @redcorporativa_interface.last_status, port: @redcorporativa_interface.port, servicio: @redcorporativa_interface.servicio, status: @redcorporativa_interface.status, time: @redcorporativa_interface.time }
    end

    assert_redirected_to redcorporativa_interface_path(assigns(:redcorporativa_interface))
  end

  test "should show redcorporativa_interface" do
    get :show, id: @redcorporativa_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @redcorporativa_interface
    assert_response :success
  end

  test "should update redcorporativa_interface" do
    patch :update, id: @redcorporativa_interface, redcorporativa_interface: { bps_max: @redcorporativa_interface.bps_max, comment: @redcorporativa_interface.comment, crecimiento_rx: @redcorporativa_interface.crecimiento_rx, crecimiento_tx: @redcorporativa_interface.crecimiento_tx, device: @redcorporativa_interface.device, deviceindex: @redcorporativa_interface.deviceindex, egressRate: @redcorporativa_interface.egressRate, gbpsrx: @redcorporativa_interface.gbpsrx, gbpstx: @redcorporativa_interface.gbpstx, last_bps_max: @redcorporativa_interface.last_bps_max, last_status: @redcorporativa_interface.last_status, port: @redcorporativa_interface.port, servicio: @redcorporativa_interface.servicio, status: @redcorporativa_interface.status, time: @redcorporativa_interface.time }
    assert_redirected_to redcorporativa_interface_path(assigns(:redcorporativa_interface))
  end

  test "should destroy redcorporativa_interface" do
    assert_difference('RedcorporativaInterface.count', -1) do
      delete :destroy, id: @redcorporativa_interface
    end

    assert_redirected_to redcorporativa_interfaces_path
  end
end
