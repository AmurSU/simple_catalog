require 'test_helper'

class SectorsControllerTest < ActionController::TestCase
  setup do
    sign_in_user
    @sector = sectors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create sector" do
    assert_difference('Sector.count') do
      post :create, record: { name: "Sectoration" }
    end
    assert_redirected_to sectors_path
  end

  test "should get edit" do
    get :edit, id: @sector
    assert_response :success
  end

  test "should update sector" do
    new_name = "Sectored"
    put :update, id: @sector, record: { name: new_name }
    assert_redirected_to sectors_path
    @sector.reload
    assert_equal new_name, @sector.name
  end

  test "should destroy sector" do
    assert_difference('Sector.count', -1) do
      delete :destroy, id: @sector
    end
    assert_redirected_to sectors_path
  end
end
