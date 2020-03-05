require 'test_helper'

class ReceiptItemsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get receipt_items_new_url
    assert_response :success
  end

  test "should get create" do
    get receipt_items_create_url
    assert_response :success
  end

  test "should get edit" do
    get receipt_items_edit_url
    assert_response :success
  end

  test "should get update" do
    get receipt_items_update_url
    assert_response :success
  end

  test "should get destroy" do
    get receipt_items_destroy_url
    assert_response :success
  end

end
