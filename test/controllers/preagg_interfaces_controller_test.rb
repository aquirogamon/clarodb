require 'test_helper'

class PreaggInterfacesControllerTest < ActionController::TestCase
  setup do
    @preagg_interface = preagg_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:preagg_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create preagg_interface" do
    assert_difference('PreaggInterface.count') do
      post :create, preagg_interface: { bps_max: @preagg_interface.bps_max, comment: @preagg_interface.comment, crecimiento: @preagg_interface.crecimiento, device: @preagg_interface.device, deviceindex: @preagg_interface.deviceindex, egressRate: @preagg_interface.egressRate, gbpsrx: @preagg_interface.gbpsrx, gbpstx: @preagg_interface.gbpstx, last_bps_max: @preagg_interface.last_bps_max, last_status: @preagg_interface.last_status, port: @preagg_interface.port, servicio: @preagg_interface.servicio, status: @preagg_interface.status, time: @preagg_interface.time }
    end

    assert_redirected_to preagg_interface_path(assigns(:preagg_interface))
  end

  test "should show preagg_interface" do
    get :show, id: @preagg_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @preagg_interface
    assert_response :success
  end

  test "should update preagg_interface" do
    patch :update, id: @preagg_interface, preagg_interface: { bps_max: @preagg_interface.bps_max, comment: @preagg_interface.comment, crecimiento: @preagg_interface.crecimiento, device: @preagg_interface.device, deviceindex: @preagg_interface.deviceindex, egressRate: @preagg_interface.egressRate, gbpsrx: @preagg_interface.gbpsrx, gbpstx: @preagg_interface.gbpstx, last_bps_max: @preagg_interface.last_bps_max, last_status: @preagg_interface.last_status, port: @preagg_interface.port, servicio: @preagg_interface.servicio, status: @preagg_interface.status, time: @preagg_interface.time }
    assert_redirected_to preagg_interface_path(assigns(:preagg_interface))
  end

  test "should destroy preagg_interface" do
    assert_difference('PreaggInterface.count', -1) do
      delete :destroy, id: @preagg_interface
    end

    assert_redirected_to preagg_interfaces_path
  end
end
