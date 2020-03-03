require 'test_helper'

class TripsControllerTest < ActionDispatch::IntegrationTest
  test "should get show" do
    get trips_show_url
    assert_response :success
  end

  test "should get export" do
    get trips_export_url
    assert_response :success
  end

end
