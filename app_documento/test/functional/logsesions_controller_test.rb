require 'test_helper'

class LogsesionsControllerTest < ActionController::TestCase
  setup do
    @logsesion = logsesions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logsesions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logsesion" do
    assert_difference('Logsesion.count') do
      post :create, logsesion: { nsuper: @logsesion.nsuper, nusuario: @logsesion.nusuario, super_id: @logsesion.super_id, tipo: @logsesion.tipo, usuario_id: @logsesion.usuario_id }
    end

    assert_redirected_to logsesion_path(assigns(:logsesion))
  end

  test "should show logsesion" do
    get :show, id: @logsesion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logsesion
    assert_response :success
  end

  test "should update logsesion" do
    put :update, id: @logsesion, logsesion: { nsuper: @logsesion.nsuper, nusuario: @logsesion.nusuario, super_id: @logsesion.super_id, tipo: @logsesion.tipo, usuario_id: @logsesion.usuario_id }
    assert_redirected_to logsesion_path(assigns(:logsesion))
  end

  test "should destroy logsesion" do
    assert_difference('Logsesion.count', -1) do
      delete :destroy, id: @logsesion
    end

    assert_redirected_to logsesions_path
  end
end
