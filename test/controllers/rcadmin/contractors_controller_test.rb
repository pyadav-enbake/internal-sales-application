require 'test_helper'

class Rcadmin::ContractorsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_contractor = rcadmin_contractors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_contractors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_contractor" do
    assert_difference('Rcadmin::Contractor.count') do
      post :create, rcadmin_contractor: { address: @rcadmin_contractor.address, admin_id: @rcadmin_contractor.admin_id, city: @rcadmin_contractor.city, email: @rcadmin_contractor.email, first_name: @rcadmin_contractor.first_name, last_name: @rcadmin_contractor.last_name, phone: @rcadmin_contractor.phone, state: @rcadmin_contractor.state, status: @rcadmin_contractor.status, zip: @rcadmin_contractor.zip }
    end

    assert_redirected_to rcadmin_contractor_path(assigns(:rcadmin_contractor))
  end

  test "should show rcadmin_contractor" do
    get :show, id: @rcadmin_contractor
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_contractor
    assert_response :success
  end

  test "should update rcadmin_contractor" do
    patch :update, id: @rcadmin_contractor, rcadmin_contractor: { address: @rcadmin_contractor.address, admin_id: @rcadmin_contractor.admin_id, city: @rcadmin_contractor.city, email: @rcadmin_contractor.email, first_name: @rcadmin_contractor.first_name, last_name: @rcadmin_contractor.last_name, phone: @rcadmin_contractor.phone, state: @rcadmin_contractor.state, status: @rcadmin_contractor.status, zip: @rcadmin_contractor.zip }
    assert_redirected_to rcadmin_contractor_path(assigns(:rcadmin_contractor))
  end

  test "should destroy rcadmin_contractor" do
    assert_difference('Rcadmin::Contractor.count', -1) do
      delete :destroy, id: @rcadmin_contractor
    end

    assert_redirected_to rcadmin_contractors_path
  end
end
