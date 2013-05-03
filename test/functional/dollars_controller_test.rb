require 'test_helper'

class DollarsControllerTest < ActionController::TestCase
  setup do
    @dollar = dollars(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:dollars)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create dollar" do
    assert_difference('Dollar.count') do
      post :create, dollar: { donation_id: @dollar.donation_id, hour_id: @dollar.hour_id }
    end

    assert_redirected_to dollar_path(assigns(:dollar))
  end

  test "should show dollar" do
    get :show, id: @dollar
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @dollar
    assert_response :success
  end

  test "should update dollar" do
    put :update, id: @dollar, dollar: { donation_id: @dollar.donation_id, hour_id: @dollar.hour_id }
    assert_redirected_to dollar_path(assigns(:dollar))
  end

  test "should destroy dollar" do
    assert_difference('Dollar.count', -1) do
      delete :destroy, id: @dollar
    end

    assert_redirected_to dollars_path
  end
end
