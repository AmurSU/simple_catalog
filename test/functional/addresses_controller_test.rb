require 'test_helper'

class AddressesControllerTest < ActionController::TestCase
  setup do
    sign_in_user
    @address = create(:address)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create address" do
    assert_difference('Address.count') do
      post :create, record: attributes_for(:address)
    end
    assert_redirected_to addresses_path
  end

  test "should get edit" do
    get :edit, id: @address
    assert_response :success
  end

  test "should update address" do
    new_url = attributes_for(:address)[:url]
    put :update, id: @address, record: { url: new_url }
    assert_redirected_to addresses_path
    @address.reload
    assert_equal new_url, @address.url
  end

  test "should destroy address" do
    assert_difference('Address.count', -1) do
      delete :destroy, id: @address
    end

    assert_redirected_to addresses_path
  end
end
