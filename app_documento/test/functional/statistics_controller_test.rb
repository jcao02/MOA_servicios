require 'test_helper'

class StatisticsControllerTest < ActionController::TestCase
  test "should get new" do
    get :new
    assert_response :success
  end

  test "should get generate" do
    get :generate
    assert_response :success
  end

end
