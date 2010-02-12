require 'test_helper'

class AbusesControllerTest < ActionController::TestCase
  test "a valid abuse" do
    failing = Factory :failing
    assert_difference "Abuse.count" do
      xhr :post, :create, login: failing.user.login,
        failing_id: failing.to_param
    end
    assert_response :success
    assert @response.body.include?("thanks!")
  end

  test "an invalid abuse" do
    failing = Factory :failing
    xhr :post, :create, login: failing.user.login, failing_id: failing.to_param
    assert_no_difference "Abuse.count" do
      xhr :post, :create, login: failing.user.login,
        failing_id: failing.to_param
    end
    assert_response :success
    assert @response.body.include?("already reported!")
  end
end
