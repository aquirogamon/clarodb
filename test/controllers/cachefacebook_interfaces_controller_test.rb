require 'test_helper'

class CachefacebookInterfacesControllerTest < ActionController::TestCase
  setup do
    @cachefacebook_interface = cachefacebook_interfaces(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cachefacebook_interfaces)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create cachefacebook_interface" do
    assert_difference('CachefacebookInterface.count') do
      post :create, cachefacebook_interface: { bps_max: @cachefacebook_interface.bps_max, comment: @cachefacebook_interface.comment, crecimiento: @cachefacebook_interface.crecimiento, device: @cachefacebook_interface.device, deviceindex: @cachefacebook_interface.deviceindex, egressRate: @cachefacebook_interface.egressRate, gbpsrx: @cachefacebook_interface.gbpsrx, gbpstx: @cachefacebook_interface.gbpstx, last_bps_max: @cachefacebook_interface.last_bps_max, last_status: @cachefacebook_interface.last_status, nodo: @cachefacebook_interface.nodo, port: @cachefacebook_interface.port, status: @cachefacebook_interface.status, time: @cachefacebook_interface.time }
    end

    assert_redirected_to cachefacebook_interface_path(assigns(:cachefacebook_interface))
  end

  test "should show cachefacebook_interface" do
    get :show, id: @cachefacebook_interface
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @cachefacebook_interface
    assert_response :success
  end

  test "should update cachefacebook_interface" do
    patch :update, id: @cachefacebook_interface, cachefacebook_interface: { bps_max: @cachefacebook_interface.bps_max, comment: @cachefacebook_interface.comment, crecimiento: @cachefacebook_interface.crecimiento, device: @cachefacebook_interface.device, deviceindex: @cachefacebook_interface.deviceindex, egressRate: @cachefacebook_interface.egressRate, gbpsrx: @cachefacebook_interface.gbpsrx, gbpstx: @cachefacebook_interface.gbpstx, last_bps_max: @cachefacebook_interface.last_bps_max, last_status: @cachefacebook_interface.last_status, nodo: @cachefacebook_interface.nodo, port: @cachefacebook_interface.port, status: @cachefacebook_interface.status, time: @cachefacebook_interface.time }
    assert_redirected_to cachefacebook_interface_path(assigns(:cachefacebook_interface))
  end

  test "should destroy cachefacebook_interface" do
    assert_difference('CachefacebookInterface.count', -1) do
      delete :destroy, id: @cachefacebook_interface
    end

    assert_redirected_to cachefacebook_interfaces_path
  end
end
