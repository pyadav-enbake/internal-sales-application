require 'test_helper'

class Rcadmin::StaticPagesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_static_page = rcadmin_static_pages(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_static_pages)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_static_page" do
    assert_difference('Rcadmin::StaticPage.count') do
      post :create, rcadmin_static_page: { content: @rcadmin_static_page.content, name: @rcadmin_static_page.name }
    end

    assert_redirected_to rcadmin_static_page_path(assigns(:rcadmin_static_page))
  end

  test "should show rcadmin_static_page" do
    get :show, id: @rcadmin_static_page
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_static_page
    assert_response :success
  end

  test "should update rcadmin_static_page" do
    patch :update, id: @rcadmin_static_page, rcadmin_static_page: { content: @rcadmin_static_page.content, name: @rcadmin_static_page.name }
    assert_redirected_to rcadmin_static_page_path(assigns(:rcadmin_static_page))
  end

  test "should destroy rcadmin_static_page" do
    assert_difference('Rcadmin::StaticPage.count', -1) do
      delete :destroy, id: @rcadmin_static_page
    end

    assert_redirected_to rcadmin_static_pages_path
  end
end
