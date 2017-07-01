require 'test_helper'

class Admin::HeaderSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_header_sections_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_header_sections_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_header_sections_edit_url
    assert_response :success
  end

  test "should get delete" do
    get admin_header_sections_delete_url
    assert_response :success
  end

end
