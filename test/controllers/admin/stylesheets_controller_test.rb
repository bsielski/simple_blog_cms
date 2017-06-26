require 'test_helper'

class Admin::StylesheetsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_stylesheets_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_stylesheets_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_stylesheets_edit_url
    assert_response :success
  end

  test "should get delete" do
    get admin_stylesheets_delete_url
    assert_response :success
  end

end
