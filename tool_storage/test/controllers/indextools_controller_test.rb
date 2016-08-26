require 'test_helper'

class IndextoolsControllerTest < ActionController::TestCase
  setup do
    @indextool = indextools(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:indextools)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create indextool" do
    assert_difference('Indextool.count') do
      post :create, indextool: { ausgeliehen: @indextool.ausgeliehen, ausgeliehen_am: @indextool.ausgeliehen_am, employee_id: @indextool.employee_id, tool_id: @indextool.tool_id }
    end

    assert_redirected_to indextool_path(assigns(:indextool))
  end

  test "should show indextool" do
    get :show, id: @indextool
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @indextool
    assert_response :success
  end

  test "should update indextool" do
    patch :update, id: @indextool, indextool: { ausgeliehen: @indextool.ausgeliehen, ausgeliehen_am: @indextool.ausgeliehen_am, employee_id: @indextool.employee_id, tool_id: @indextool.tool_id }
    assert_redirected_to indextool_path(assigns(:indextool))
  end

  test "should destroy indextool" do
    assert_difference('Indextool.count', -1) do
      delete :destroy, id: @indextool
    end

    assert_redirected_to indextools_path
  end
end
