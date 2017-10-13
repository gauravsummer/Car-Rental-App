require 'test_helper'

class CarRentalControllerTest < ActionDispatch::IntegrationTest
  test "should get home" do
    get car_rental_home_url
    assert_response :success
  end

  test "should get help" do
    get car_rental_help_url
    assert_response :success
  end

  test "should get about" do
    get car_rental_about_url
    assert_response :success
  end
end
