require 'test_helper'

class Rcadmin::CabinetTypesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_cabinet_type = rcadmin_cabinet_types(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_cabinet_types)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_cabinet_type" do
    assert_difference('Rcadmin::CabinetType.count') do
      post :create, rcadmin_cabinet_type: { name: @rcadmin_cabinet_type.name, status: @rcadmin_cabinet_type.status }
    end

    assert_redirected_to rcadmin_cabinet_type_path(assigns(:rcadmin_cabinet_type))
  end

  test "should show rcadmin_cabinet_type" do
    get :show, id: @rcadmin_cabinet_type
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_cabinet_type
    assert_response :success
  end

  test "should update rcadmin_cabinet_type" do
    patch :update, id: @rcadmin_cabinet_type, rcadmin_cabinet_type: { name: @rcadmin_cabinet_type.name, status: @rcadmin_cabinet_type.status }
    assert_redirected_to rcadmin_cabinet_type_path(assigns(:rcadmin_cabinet_type))
  end

  test "should destroy rcadmin_cabinet_type" do
    assert_difference('Rcadmin::CabinetType.count', -1) do
      delete :destroy, id: @rcadmin_cabinet_type
    end

    assert_redirected_to rcadmin_cabinet_types_path
  end
end
