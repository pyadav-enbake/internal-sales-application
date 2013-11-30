require 'test_helper'

class Rcadmin::EmailTemplatesControllerTest < ActionController::TestCase
  setup do
    @rcadmin_email_template = rcadmin_email_templates(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:rcadmin_email_templates)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create rcadmin_email_template" do
    assert_difference('Rcadmin::EmailTemplate.count') do
      post :create, rcadmin_email_template: { message_body: @rcadmin_email_template.message_body, template_name: @rcadmin_email_template.template_name }
    end

    assert_redirected_to rcadmin_email_template_path(assigns(:rcadmin_email_template))
  end

  test "should show rcadmin_email_template" do
    get :show, id: @rcadmin_email_template
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @rcadmin_email_template
    assert_response :success
  end

  test "should update rcadmin_email_template" do
    patch :update, id: @rcadmin_email_template, rcadmin_email_template: { message_body: @rcadmin_email_template.message_body, template_name: @rcadmin_email_template.template_name }
    assert_redirected_to rcadmin_email_template_path(assigns(:rcadmin_email_template))
  end

  test "should destroy rcadmin_email_template" do
    assert_difference('Rcadmin::EmailTemplate.count', -1) do
      delete :destroy, id: @rcadmin_email_template
    end

    assert_redirected_to rcadmin_email_templates_path
  end
end
