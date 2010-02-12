require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  test "a valid comment" do
    failing = Factory :failing
    assert_difference "Comment.count" do
      xhr :post, :create, login: failing.user.login, failing_id: failing.id,
        comment: { text: "I disagree." }
    end
    assert_response :success
    assert @response.body.include?("I disagree.")
  end

  test "an invalid comment" do
    failing = Factory :failing
    assert_no_difference "Comment.count" do
      xhr :post, :create, login: failing.user.login, failing_id: failing.id,
        comment: { text: "I disagree." * 200 }
    end
    assert_response :success
    assert @response.body.include?("alert")
  end
end
