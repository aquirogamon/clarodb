require 'test_helper'

class CoreInterfacesControllerTest < ActionController::TestCase
  setup do
    @core_interface = core_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:core_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create core_interface" do
    assert_difference('CoreInterface.count') do
      post :create, core_interface: { bps_max: @core_interface.bps_max, comment: @core_interface.comment, crecimiento: @core_interface.crecimiento, device: @core_interface.device, deviceindex: @core_interface.deviceindex, egressRate: @core_interface.egressRate, gbpsrx: @core_interface.gbpsrx, gbpstx: @core_interface.gbpstx, last_bps_max: @core_interface.last_bps_max, last_status: @core_interface.last_status, port: @core_interface.port, servicio: @core_interface.servicio, status: @core_interface.status, time: @core_interface.time }
    end

    assert_redirected_to core_interface_path(assigns(:core_interface))
  end

  test "should show core_interface" do
    get :show, id: @core_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @core_interface
    assert_response :success
  end

  test "should update core_interface" do
    patch :update, id: @core_interface, core_interface: { bps_max: @core_interface.bps_max, comment: @core_interface.comment, crecimiento: @core_interface.crecimiento, device: @core_interface.device, deviceindex: @core_interface.deviceindex, egressRate: @core_interface.egressRate, gbpsrx: @core_interface.gbpsrx, gbpstx: @core_interface.gbpstx, last_bps_max: @core_interface.last_bps_max, last_status: @core_interface.last_status, port: @core_interface.port, servicio: @core_interface.servicio, status: @core_interface.status, time: @core_interface.time }
    assert_redirected_to core_interface_path(assigns(:core_interface))
  end

  test "should destroy core_interface" do
    assert_difference('CoreInterface.count', -1) do
      delete :destroy, id: @core_interface
    end

    assert_redirected_to core_interfaces_path
  end
end
