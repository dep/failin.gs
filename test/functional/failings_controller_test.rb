require 'test_helper'

class FailingsControllerTest < ActionController::TestCase
  test "get empty profile" do
    get :index, login: Factory(:user).login
    assert_response :success
    assert @response.body.include?("brand new")
  end

  test "get private profile" do
    get :index, login: Factory(:user, private: true).login
    assert_response :success
    assert !@response.body.include?("brand new")
    assert !@response.body.include?("This category is empty")
    assert @response.body.include?("private")
  end

  test "get public profile" do
    get :index, login: Factory(:failing).user.login
    assert_response :success
    assert !@response.body.include?("brand new")
    assert @response.body.include?("This category is empty")
    assert !@response.body.include?("private")
  end

  test "submit failing" do
    assert_difference "Failing.count" do
      post :create, login: Factory(:user).login,
        failing: { about: "You smell." }
    end
    assert_response :redirect
    assert_redirected_to profile_path(@user)
    assert_not_nil flash[:notice]
  end

  test "show failing" do
    failing = Factory :failing
    get :show, login: failing.user.login, id: failing.id
    assert_response :success
    assert @response.body.include?(failing.about[/^.+$/])
  end

  test "don't show private failing to guest" do
    failing = Factory :failing, user: Factory(:user, private: true)
    get :show, login: failing.user.login, id: failing.id
    assert_response :redirect
    assert_redirected_to profile_path(failing.user)
  end

  # test "show private failing to user" do
  #   failing = Factory :failing, user: Factory(:user, private: true)
  #   login_as failing.user
  #   get :show, login: failing.user.login, id: failing.id
  #   assert_response :success
  #   assert @response.body.include?(failing.about[/^.+$/])
  # end
end
