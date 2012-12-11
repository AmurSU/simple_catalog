require 'test_helper'

class UsersControllerTest < ActionController::TestCase
  setup do
    sign_in_user
    @user = create(:user)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post :create, record: attributes_for(:user)
    end
    assert_redirected_to users_path
  end

  test "should get edit" do
    get :edit, id: @user
    assert_response :success
  end

  test "should update user" do
    new_email = "petechkin@amursu.ru"
    put :update, id: @user, record: { email: new_email }
    assert_redirected_to users_path
    @user.reload
    assert_equal new_email, @user.email
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete :destroy, id: @user
    end
    assert_redirected_to users_path
  end
end
