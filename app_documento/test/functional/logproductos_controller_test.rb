require 'test_helper'

class LogproductosControllerTest < ActionController::TestCase
  setup do
    @logproducto = logproductos(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:logproductos)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create logproducto" do
    assert_difference('Logproducto.count') do
      post :create, logproducto: { producto_id: @logproducto.producto_id, tipo: @logproducto.tipo, usuario_id: @logproducto.usuario_id }
    end

    assert_redirected_to logproducto_path(assigns(:logproducto))
  end

  test "should show logproducto" do
    get :show, id: @logproducto
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @logproducto
    assert_response :success
  end

  test "should update logproducto" do
    put :update, id: @logproducto, logproducto: { producto_id: @logproducto.producto_id, tipo: @logproducto.tipo, usuario_id: @logproducto.usuario_id }
    assert_redirected_to logproducto_path(assigns(:logproducto))
  end

  test "should destroy logproducto" do
    assert_difference('Logproducto.count', -1) do
      delete :destroy, id: @logproducto
    end

    assert_redirected_to logproductos_path
  end
end
