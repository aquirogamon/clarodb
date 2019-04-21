require 'test_helper'

class InternetInterfacesControllerTest < ActionController::TestCase
  setup do
    @internet_interface = internet_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:internet_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create internet_interface" do
    assert_difference('InternetInterface.count') do
      post :create, internet_interface: { bps_max: @internet_interface.bps_max, comment: @internet_interface.comment, crecimiento: @internet_interface.crecimiento, device: @internet_interface.device, deviceindex: @internet_interface.deviceindex, egressRate: @internet_interface.egressRate, gbpsrx: @internet_interface.gbpsrx, gbpstx: @internet_interface.gbpstx, last_bps_max: @internet_interface.last_bps_max, last_status: @internet_interface.last_status, neighbor: @internet_interface.neighbor, port: @internet_interface.port, servicio: @internet_interface.servicio, status: @internet_interface.status, time: @internet_interface.time }
    end

    assert_redirected_to internet_interface_path(assigns(:internet_interface))
  end

  test "should show internet_interface" do
    get :show, id: @internet_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @internet_interface
    assert_response :success
  end

  test "should update internet_interface" do
    patch :update, id: @internet_interface, internet_interface: { bps_max: @internet_interface.bps_max, comment: @internet_interface.comment, crecimiento: @internet_interface.crecimiento, device: @internet_interface.device, deviceindex: @internet_interface.deviceindex, egressRate: @internet_interface.egressRate, gbpsrx: @internet_interface.gbpsrx, gbpstx: @internet_interface.gbpstx, last_bps_max: @internet_interface.last_bps_max, last_status: @internet_interface.last_status, neighbor: @internet_interface.neighbor, port: @internet_interface.port, servicio: @internet_interface.servicio, status: @internet_interface.status, time: @internet_interface.time }
    assert_redirected_to internet_interface_path(assigns(:internet_interface))
  end

  test "should destroy internet_interface" do
    assert_difference('InternetInterface.count', -1) do
      delete :destroy, id: @internet_interface
    end

    assert_redirected_to internet_interfaces_path
  end
end
