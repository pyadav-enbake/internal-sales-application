require 'test_helper'

class Rcadmin::DimensionCategoriesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_dimension_category = rcadmin_dimension_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_dimension_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_dimension_category" do
    assert_difference('Rcadmin::DimensionCategory.count') do
      post :create, rcadmin_dimension_category: { name: @rcadmin_dimension_category.name }
    end

    assert_redirected_to rcadmin_dimension_category_path(assigns(:rcadmin_dimension_category))
  end

  test "should show rcadmin_dimension_category" do
    get :show, id: @rcadmin_dimension_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_dimension_category
    assert_response :success
  end

  test "should update rcadmin_dimension_category" do
    patch :update, id: @rcadmin_dimension_category, rcadmin_dimension_category: { name: @rcadmin_dimension_category.name }
    assert_redirected_to rcadmin_dimension_category_path(assigns(:rcadmin_dimension_category))
  end

  test "should destroy rcadmin_dimension_category" do
    assert_difference('Rcadmin::DimensionCategory.count', -1) do
      delete :destroy, id: @rcadmin_dimension_category
    end

    assert_redirected_to rcadmin_dimension_categories_path
  end
end
