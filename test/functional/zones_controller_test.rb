require 'test_helper'

class ZonesControllerTest < ActionController::TestCase
  setup do
    sign_in_user
    @zone = zones(:org_ru)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create zone" do
    assert_difference('Zone.count') do
      post :create, record: { description: @zone.description, suffix: ".net.com" }
    end
    assert_redirected_to zones_path
  end

  test "should get edit" do
    get :edit, id: @zone
    assert_response :success
  end

  test "should update zone" do
    new_suffix = ".com.net"
    put :update, id: @zone, record: { description: @zone.description, suffix: new_suffix }
    assert_redirected_to zones_path
    @zone.reload
    assert_equal new_suffix, @zone.suffix
  end

  test "should destroy zone" do
    assert_difference('Zone.count', -1) do
      delete :destroy, id: @zone
    end
    assert_redirected_to zones_path
  end
end
