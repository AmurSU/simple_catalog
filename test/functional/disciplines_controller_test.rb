require 'test_helper'

class DisciplinesControllerTest < ActionController::TestCase
  setup do
    sign_in_user
    @discipline = disciplines(:otu)
  end

  test "should get index" do
    get :index
    assert_response :success
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create discipline" do
    assert_difference('Discipline.count') do
      post :create, record: { name: "Informatics" }
    end
    assert_redirected_to disciplines_path
  end

  test "should get edit" do
    get :edit, id: @discipline
    assert_response :success
  end

  test "should update discipline" do
    new_name = "Oh my discipline!"
    put :update, id: @discipline, record: { name: new_name }
    assert_redirected_to disciplines_path
    @discipline.reload
    assert_equal new_name, @discipline.name
  end

  test "should destroy discipline" do
    assert_difference('Discipline.count', -1) do
      delete :destroy, id: @discipline
    end
    assert_redirected_to disciplines_path
  end
end
