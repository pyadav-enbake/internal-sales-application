require 'test_helper'

class Rcadmin::CustomersControllerTest < ActionController::TestCase
  setup do
    @rcadmin_customer = rcadmin_customers(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_customers)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_customer" do
    assert_difference('Rcadmin::Customer.count') do
      post :create, rcadmin_customer: { adress: @rcadmin_customer.adress, city: @rcadmin_customer.city, email: @rcadmin_customer.email, first_name: @rcadmin_customer.first_name, last_name: @rcadmin_customer.last_name, phone: @rcadmin_customer.phone, state: @rcadmin_customer.state, status: @rcadmin_customer.status, zip: @rcadmin_customer.zip }
    end

    assert_redirected_to rcadmin_customer_path(assigns(:rcadmin_customer))
  end

  test "should show rcadmin_customer" do
    get :show, id: @rcadmin_customer
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_customer
    assert_response :success
  end

  test "should update rcadmin_customer" do
    patch :update, id: @rcadmin_customer, rcadmin_customer: { adress: @rcadmin_customer.adress, city: @rcadmin_customer.city, email: @rcadmin_customer.email, first_name: @rcadmin_customer.first_name, last_name: @rcadmin_customer.last_name, phone: @rcadmin_customer.phone, state: @rcadmin_customer.state, status: @rcadmin_customer.status, zip: @rcadmin_customer.zip }
    assert_redirected_to rcadmin_customer_path(assigns(:rcadmin_customer))
  end

  test "should destroy rcadmin_customer" do
    assert_difference('Rcadmin::Customer.count', -1) do
      delete :destroy, id: @rcadmin_customer
    end

    assert_redirected_to rcadmin_customers_path
  end
end
