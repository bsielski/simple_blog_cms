require 'test_helper'

class Admin::FooterSectionsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admin_footer_sections_index_url
    assert_response :success
  end

  test "should get new" do
    get admin_footer_sections_new_url
    assert_response :success
  end

  test "should get edit" do
    get admin_footer_sections_edit_url
    assert_response :success
  end

  test "should get delete" do
    get admin_footer_sections_delete_url
    assert_response :success
  end

end
