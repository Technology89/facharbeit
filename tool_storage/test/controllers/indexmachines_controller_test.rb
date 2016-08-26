require 'test_helper'

class IndexmachinesControllerTest < ActionController::TestCase
  setup do
    @indexmachine = indexmachines(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:indexmachines)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create indexmachine" do
    assert_difference('Indexmachine.count') do
      post :create, indexmachine: { ausgeliehen: @indexmachine.ausgeliehen, ausgeliehen_am: @indexmachine.ausgeliehen_am, employee_id: @indexmachine.employee_id, machine_id: @indexmachine.machine_id }
    end

    assert_redirected_to indexmachine_path(assigns(:indexmachine))
  end

  test "should show indexmachine" do
    get :show, id: @indexmachine
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @indexmachine
    assert_response :success
  end

  test "should update indexmachine" do
    patch :update, id: @indexmachine, indexmachine: { ausgeliehen: @indexmachine.ausgeliehen, ausgeliehen_am: @indexmachine.ausgeliehen_am, employee_id: @indexmachine.employee_id, machine_id: @indexmachine.machine_id }
    assert_redirected_to indexmachine_path(assigns(:indexmachine))
  end

  test "should destroy indexmachine" do
    assert_difference('Indexmachine.count', -1) do
      delete :destroy, id: @indexmachine
    end

    assert_redirected_to indexmachines_path
  end
end
