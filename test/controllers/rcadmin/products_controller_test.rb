require 'test_helper'

class Rcadmin::ProductsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_product = rcadmin_products(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_products)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_product" do
    assert_difference('Rcadmin::Product.count') do
      post :create, rcadmin_product: { categotry_id: @rcadmin_product.categotry_id, dimension_id: @rcadmin_product.dimension_id, name: @rcadmin_product.name, price: @rcadmin_product.price }
    end

    assert_redirected_to rcadmin_product_path(assigns(:rcadmin_product))
  end

  test "should show rcadmin_product" do
    get :show, id: @rcadmin_product
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_product
    assert_response :success
  end

  test "should update rcadmin_product" do
    patch :update, id: @rcadmin_product, rcadmin_product: { categotry_id: @rcadmin_product.categotry_id, dimension_id: @rcadmin_product.dimension_id, name: @rcadmin_product.name, price: @rcadmin_product.price }
    assert_redirected_to rcadmin_product_path(assigns(:rcadmin_product))
  end

  test "should destroy rcadmin_product" do
    assert_difference('Rcadmin::Product.count', -1) do
      delete :destroy, id: @rcadmin_product
    end

    assert_redirected_to rcadmin_products_path
  end
end
