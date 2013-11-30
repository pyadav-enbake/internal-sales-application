require 'test_helper'

class Rcadmin::FaqCategoriesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_faq_category = rcadmin_faq_categories(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_faq_categories)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_faq_category" do
    assert_difference('Rcadmin::FaqCategory.count') do
      post :create, rcadmin_faq_category: { description: @rcadmin_faq_category.description, display_order: @rcadmin_faq_category.display_order, name: @rcadmin_faq_category.name, status: @rcadmin_faq_category.status }
    end

    assert_redirected_to rcadmin_faq_category_path(assigns(:rcadmin_faq_category))
  end

  test "should show rcadmin_faq_category" do
    get :show, id: @rcadmin_faq_category
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_faq_category
    assert_response :success
  end

  test "should update rcadmin_faq_category" do
    patch :update, id: @rcadmin_faq_category, rcadmin_faq_category: { description: @rcadmin_faq_category.description, display_order: @rcadmin_faq_category.display_order, name: @rcadmin_faq_category.name, status: @rcadmin_faq_category.status }
    assert_redirected_to rcadmin_faq_category_path(assigns(:rcadmin_faq_category))
  end

  test "should destroy rcadmin_faq_category" do
    assert_difference('Rcadmin::FaqCategory.count', -1) do
      delete :destroy, id: @rcadmin_faq_category
    end

    assert_redirected_to rcadmin_faq_categories_path
  end
end
