require 'test_helper'

class EmailsControllerTest < ActionController::TestCase
  test "a new email" do
    assert_difference "Email.count" do
      xhr :post, :create, email: { address: "new@example.com" }
    end
    assert_response :success
    assert @response.body.include?("thankyou")
  end

  test "a duplicate email" do
    email = Factory :email
    assert_no_difference "Email.count" do
      xhr :post, :create, email: { address: email.address }
    end
    assert_response :success
    assert @response.body.include?("has already signed up")
  end
end
