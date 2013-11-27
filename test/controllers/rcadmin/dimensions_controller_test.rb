require 'test_helper'

class Rcadmin::DimensionsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_dimension = rcadmin_dimensions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_dimensions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_dimension" do
    assert_difference('Rcadmin::Dimension.count') do
      post :create, rcadmin_dimension: { dimension_categotry_id: @rcadmin_dimension.dimension_categotry_id, lower_limit: @rcadmin_dimension.lower_limit, upper_limit: @rcadmin_dimension.upper_limit }
    end

    assert_redirected_to rcadmin_dimension_path(assigns(:rcadmin_dimension))
  end

  test "should show rcadmin_dimension" do
    get :show, id: @rcadmin_dimension
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_dimension
    assert_response :success
  end

  test "should update rcadmin_dimension" do
    patch :update, id: @rcadmin_dimension, rcadmin_dimension: { dimension_categotry_id: @rcadmin_dimension.dimension_categotry_id, lower_limit: @rcadmin_dimension.lower_limit, upper_limit: @rcadmin_dimension.upper_limit }
    assert_redirected_to rcadmin_dimension_path(assigns(:rcadmin_dimension))
  end

  test "should destroy rcadmin_dimension" do
    assert_difference('Rcadmin::Dimension.count', -1) do
      delete :destroy, id: @rcadmin_dimension
    end

    assert_redirected_to rcadmin_dimensions_path
  end
end
