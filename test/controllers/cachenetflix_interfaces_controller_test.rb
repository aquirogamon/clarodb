require 'test_helper'

class CachenetflixInterfacesControllerTest < ActionController::TestCase
  setup do
    @cachenetflix_interface = cachenetflix_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cachenetflix_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cachenetflix_interface" do
    assert_difference('CachenetflixInterface.count') do
      post :create, cachenetflix_interface: { bps_max: @cachenetflix_interface.bps_max, comment: @cachenetflix_interface.comment, crecimiento: @cachenetflix_interface.crecimiento, device: @cachenetflix_interface.device, deviceindex: @cachenetflix_interface.deviceindex, egressRate: @cachenetflix_interface.egressRate, gbpsrx: @cachenetflix_interface.gbpsrx, gbpstx: @cachenetflix_interface.gbpstx, last_bps_max: @cachenetflix_interface.last_bps_max, last_status: @cachenetflix_interface.last_status, nodo: @cachenetflix_interface.nodo, port: @cachenetflix_interface.port, status: @cachenetflix_interface.status, time: @cachenetflix_interface.time }
    end

    assert_redirected_to cachenetflix_interface_path(assigns(:cachenetflix_interface))
  end

  test "should show cachenetflix_interface" do
    get :show, id: @cachenetflix_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cachenetflix_interface
    assert_response :success
  end

  test "should update cachenetflix_interface" do
    patch :update, id: @cachenetflix_interface, cachenetflix_interface: { bps_max: @cachenetflix_interface.bps_max, comment: @cachenetflix_interface.comment, crecimiento: @cachenetflix_interface.crecimiento, device: @cachenetflix_interface.device, deviceindex: @cachenetflix_interface.deviceindex, egressRate: @cachenetflix_interface.egressRate, gbpsrx: @cachenetflix_interface.gbpsrx, gbpstx: @cachenetflix_interface.gbpstx, last_bps_max: @cachenetflix_interface.last_bps_max, last_status: @cachenetflix_interface.last_status, nodo: @cachenetflix_interface.nodo, port: @cachenetflix_interface.port, status: @cachenetflix_interface.status, time: @cachenetflix_interface.time }
    assert_redirected_to cachenetflix_interface_path(assigns(:cachenetflix_interface))
  end

  test "should destroy cachenetflix_interface" do
    assert_difference('CachenetflixInterface.count', -1) do
      delete :destroy, id: @cachenetflix_interface
    end

    assert_redirected_to cachenetflix_interfaces_path
  end
end
