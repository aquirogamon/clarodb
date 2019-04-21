require 'test_helper'

class AccessInternetsControllerTest < ActionController::TestCase
  setup do
    @access_internet = access_internets(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:access_internets)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create access_internet" do
    assert_difference('AccessInternet.count') do
      post :create, access_internet: { cache_in: @access_internet.cache_in, corporate: @access_internet.corporate, hfc: @access_internet.hfc, hfc_cgn: @access_internet.hfc_cgn, hfc_ipv6: @access_internet.hfc_ipv6, hfc_public: @access_internet.hfc_public, mobile: @access_internet.mobile, mobile_cgn: @access_internet.mobile_cgn, mobile_corporate: @access_internet.mobile_corporate, mobile_ipv6: @access_internet.mobile_ipv6, mobile_olo: @access_internet.mobile_olo, total_traffic: @access_internet.total_traffic }
    end

    assert_redirected_to access_internet_path(assigns(:access_internet))
  end

  test "should show access_internet" do
    get :show, id: @access_internet
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @access_internet
    assert_response :success
  end

  test "should update access_internet" do
    patch :update, id: @access_internet, access_internet: { cache_in: @access_internet.cache_in, corporate: @access_internet.corporate, hfc: @access_internet.hfc, hfc_cgn: @access_internet.hfc_cgn, hfc_ipv6: @access_internet.hfc_ipv6, hfc_public: @access_internet.hfc_public, mobile: @access_internet.mobile, mobile_cgn: @access_internet.mobile_cgn, mobile_corporate: @access_internet.mobile_corporate, mobile_ipv6: @access_internet.mobile_ipv6, mobile_olo: @access_internet.mobile_olo, total_traffic: @access_internet.total_traffic }
    assert_redirected_to access_internet_path(assigns(:access_internet))
  end

  test "should destroy access_internet" do
    assert_difference('AccessInternet.count', -1) do
      delete :destroy, id: @access_internet
    end

    assert_redirected_to access_internets_path
  end
end
