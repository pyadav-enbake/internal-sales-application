require 'test_helper'

class Rcadmin::FaqsControllerTest < ActionController::TestCase
  setup do
    @rcadmin_faq = rcadmin_faqs(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_faqs)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_faq" do
    assert_difference('Rcadmin::Faq.count') do
      post :create, rcadmin_faq: { answer: @rcadmin_faq.answer, display_order: @rcadmin_faq.display_order, faqs_category_id: @rcadmin_faq.faqs_category_id, question: @rcadmin_faq.question, status: @rcadmin_faq.status }
    end

    assert_redirected_to rcadmin_faq_path(assigns(:rcadmin_faq))
  end

  test "should show rcadmin_faq" do
    get :show, id: @rcadmin_faq
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_faq
    assert_response :success
  end

  test "should update rcadmin_faq" do
    patch :update, id: @rcadmin_faq, rcadmin_faq: { answer: @rcadmin_faq.answer, display_order: @rcadmin_faq.display_order, faqs_category_id: @rcadmin_faq.faqs_category_id, question: @rcadmin_faq.question, status: @rcadmin_faq.status }
    assert_redirected_to rcadmin_faq_path(assigns(:rcadmin_faq))
  end

  test "should destroy rcadmin_faq" do
    assert_difference('Rcadmin::Faq.count', -1) do
      delete :destroy, id: @rcadmin_faq
    end

    assert_redirected_to rcadmin_faqs_path
  end
end
