require 'test_helper'

class Rcadmin::LoginLogsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_login_log = rcadmin_login_logs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_login_logs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_login_log" do
    assert_difference('Rcadmin::LoginLog.count') do
      post :create, rcadmin_login_log: { email: @rcadmin_login_log.email, first_name: @rcadmin_login_log.first_name, ip: @rcadmin_login_log.ip, last_name: @rcadmin_login_log.last_name, login_time: @rcadmin_login_log.login_time, logout_time: @rcadmin_login_log.logout_time }
    end

    assert_redirected_to rcadmin_login_log_path(assigns(:rcadmin_login_log))
  end

  test "should show rcadmin_login_log" do
    get :show, id: @rcadmin_login_log
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_login_log
    assert_response :success
  end

  test "should update rcadmin_login_log" do
    patch :update, id: @rcadmin_login_log, rcadmin_login_log: { email: @rcadmin_login_log.email, first_name: @rcadmin_login_log.first_name, ip: @rcadmin_login_log.ip, last_name: @rcadmin_login_log.last_name, login_time: @rcadmin_login_log.login_time, logout_time: @rcadmin_login_log.logout_time }
    assert_redirected_to rcadmin_login_log_path(assigns(:rcadmin_login_log))
  end

  test "should destroy rcadmin_login_log" do
    assert_difference('Rcadmin::LoginLog.count', -1) do
      delete :destroy, id: @rcadmin_login_log
    end

    assert_redirected_to rcadmin_login_logs_path
  end
end
