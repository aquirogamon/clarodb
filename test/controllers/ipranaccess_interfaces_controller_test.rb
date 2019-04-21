require 'test_helper'

class IpranaccessInterfacesControllerTest < ActionController::TestCase
  setup do
    @ipranaccess_interface = ipranaccess_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:ipranaccess_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create ipranaccess_interface" do
    assert_difference('IpranaccessInterface.count') do
      post :create, ipranaccess_interface: { bps_max: @ipranaccess_interface.bps_max, comment: @ipranaccess_interface.comment, crecimiento: @ipranaccess_interface.crecimiento, description: @ipranaccess_interface.description, device: @ipranaccess_interface.device, deviceindex: @ipranaccess_interface.deviceindex, egressRate: @ipranaccess_interface.egressRate, gbpsrx: @ipranaccess_interface.gbpsrx, gbpstx: @ipranaccess_interface.gbpstx, last_bps_max: @ipranaccess_interface.last_bps_max, last_status: @ipranaccess_interface.last_status, port: @ipranaccess_interface.port, speed: @ipranaccess_interface.speed, status: @ipranaccess_interface.status, time: @ipranaccess_interface.time }
    end

    assert_redirected_to ipranaccess_interface_path(assigns(:ipranaccess_interface))
  end

  test "should show ipranaccess_interface" do
    get :show, id: @ipranaccess_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @ipranaccess_interface
    assert_response :success
  end

  test "should update ipranaccess_interface" do
    patch :update, id: @ipranaccess_interface, ipranaccess_interface: { bps_max: @ipranaccess_interface.bps_max, comment: @ipranaccess_interface.comment, crecimiento: @ipranaccess_interface.crecimiento, description: @ipranaccess_interface.description, device: @ipranaccess_interface.device, deviceindex: @ipranaccess_interface.deviceindex, egressRate: @ipranaccess_interface.egressRate, gbpsrx: @ipranaccess_interface.gbpsrx, gbpstx: @ipranaccess_interface.gbpstx, last_bps_max: @ipranaccess_interface.last_bps_max, last_status: @ipranaccess_interface.last_status, port: @ipranaccess_interface.port, speed: @ipranaccess_interface.speed, status: @ipranaccess_interface.status, time: @ipranaccess_interface.time }
    assert_redirected_to ipranaccess_interface_path(assigns(:ipranaccess_interface))
  end

  test "should destroy ipranaccess_interface" do
    assert_difference('IpranaccessInterface.count', -1) do
      delete :destroy, id: @ipranaccess_interface
    end

    assert_redirected_to ipranaccess_interfaces_path
  end
end
