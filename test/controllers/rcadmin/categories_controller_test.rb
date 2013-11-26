require 'test_helper'

class Rcadmin::CategoriesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_category = rcadmin_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_category" do
    assert_difference('Rcadmin::Category.count') do
      post :create, rcadmin_category: { name: @rcadmin_category.name }
    end

    assert_redirected_to rcadmin_category_path(assigns(:rcadmin_category))
  end

  test "should show rcadmin_category" do
    get :show, id: @rcadmin_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_category
    assert_response :success
  end

  test "should update rcadmin_category" do
    patch :update, id: @rcadmin_category, rcadmin_category: { name: @rcadmin_category.name }
    assert_redirected_to rcadmin_category_path(assigns(:rcadmin_category))
  end

  test "should destroy rcadmin_category" do
    assert_difference('Rcadmin::Category.count', -1) do
      delete :destroy, id: @rcadmin_category
    end

    assert_redirected_to rcadmin_categories_path
  end
end
