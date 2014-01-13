require 'test_helper'

class Rcadmin::CountertopDesignsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_countertop_design = rcadmin_countertop_designs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_countertop_designs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_countertop_design" do
    assert_difference('Rcadmin::CountertopDesign.count') do
      post :create, rcadmin_countertop_design: { name: @rcadmin_countertop_design.name, status: @rcadmin_countertop_design.status }
    end

    assert_redirected_to rcadmin_countertop_design_path(assigns(:rcadmin_countertop_design))
  end

  test "should show rcadmin_countertop_design" do
    get :show, id: @rcadmin_countertop_design
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_countertop_design
    assert_response :success
  end

  test "should update rcadmin_countertop_design" do
    patch :update, id: @rcadmin_countertop_design, rcadmin_countertop_design: { name: @rcadmin_countertop_design.name, status: @rcadmin_countertop_design.status }
    assert_redirected_to rcadmin_countertop_design_path(assigns(:rcadmin_countertop_design))
  end

  test "should destroy rcadmin_countertop_design" do
    assert_difference('Rcadmin::CountertopDesign.count', -1) do
      delete :destroy, id: @rcadmin_countertop_design
    end

    assert_redirected_to rcadmin_countertop_designs_path
  end
end
