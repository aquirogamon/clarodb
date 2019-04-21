require 'test_helper'

class IpranedgeInterfacesControllerTest < ActionController::TestCase
  setup do
    @ipranedge_interface = ipranedge_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ipranedge_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ipranedge_interface" do
    assert_difference('IpranedgeInterface.count') do
      post :create, ipranedge_interface: { bps_max: @ipranedge_interface.bps_max, comment: @ipranedge_interface.comment, crecimiento: @ipranedge_interface.crecimiento, description: @ipranedge_interface.description, device: @ipranedge_interface.device, deviceindex: @ipranedge_interface.deviceindex, egressRate: @ipranedge_interface.egressRate, gbpsrx: @ipranedge_interface.gbpsrx, gbpstx: @ipranedge_interface.gbpstx, last_bps_max: @ipranedge_interface.last_bps_max, last_status: @ipranedge_interface.last_status, port: @ipranedge_interface.port, speed: @ipranedge_interface.speed, status: @ipranedge_interface.status, time: @ipranedge_interface.time }
    end

    assert_redirected_to ipranedge_interface_path(assigns(:ipranedge_interface))
  end

  test "should show ipranedge_interface" do
    get :show, id: @ipranedge_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ipranedge_interface
    assert_response :success
  end

  test "should update ipranedge_interface" do
    patch :update, id: @ipranedge_interface, ipranedge_interface: { bps_max: @ipranedge_interface.bps_max, comment: @ipranedge_interface.comment, crecimiento: @ipranedge_interface.crecimiento, description: @ipranedge_interface.description, device: @ipranedge_interface.device, deviceindex: @ipranedge_interface.deviceindex, egressRate: @ipranedge_interface.egressRate, gbpsrx: @ipranedge_interface.gbpsrx, gbpstx: @ipranedge_interface.gbpstx, last_bps_max: @ipranedge_interface.last_bps_max, last_status: @ipranedge_interface.last_status, port: @ipranedge_interface.port, speed: @ipranedge_interface.speed, status: @ipranedge_interface.status, time: @ipranedge_interface.time }
    assert_redirected_to ipranedge_interface_path(assigns(:ipranedge_interface))
  end

  test "should destroy ipranedge_interface" do
    assert_difference('IpranedgeInterface.count', -1) do
      delete :destroy, id: @ipranedge_interface
    end

    assert_redirected_to ipranedge_interfaces_path
  end
end
