require 'test_helper'

class Rcadmin::SubcategoriesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_subcategory = rcadmin_subcategories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_subcategories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_subcategory" do
    assert_difference('Rcadmin::Subcategory.count') do
      post :create, rcadmin_subcategory: { category_id: @rcadmin_subcategory.category_id, name: @rcadmin_subcategory.name, status: @rcadmin_subcategory.status }
    end

    assert_redirected_to rcadmin_subcategory_path(assigns(:rcadmin_subcategory))
  end

  test "should show rcadmin_subcategory" do
    get :show, id: @rcadmin_subcategory
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_subcategory
    assert_response :success
  end

  test "should update rcadmin_subcategory" do
    patch :update, id: @rcadmin_subcategory, rcadmin_subcategory: { category_id: @rcadmin_subcategory.category_id, name: @rcadmin_subcategory.name, status: @rcadmin_subcategory.status }
    assert_redirected_to rcadmin_subcategory_path(assigns(:rcadmin_subcategory))
  end

  test "should destroy rcadmin_subcategory" do
    assert_difference('Rcadmin::Subcategory.count', -1) do
      delete :destroy, id: @rcadmin_subcategory
    end

    assert_redirected_to rcadmin_subcategories_path
  end
end
