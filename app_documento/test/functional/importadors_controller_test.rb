require 'test_helper'

class ImportadorsControllerTest < ActionController::TestCase
  setup do
    @importador = importadors(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:importadors)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create importador" do
    assert_difference('Importador.count') do
      post :create, importador: { mail: @importador.mail, nombre: @importador.nombre, pais_origen: @importador.pais_origen, rif: @importador.rif, telefono: @importador.telefono }
    end

    assert_redirected_to importador_path(assigns(:importador))
  end

  test "should show importador" do
    get :show, id: @importador
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @importador
    assert_response :success
  end

  test "should update importador" do
    put :update, id: @importador, importador: { mail: @importador.mail, nombre: @importador.nombre, pais_origen: @importador.pais_origen, rif: @importador.rif, telefono: @importador.telefono }
    assert_redirected_to importador_path(assigns(:importador))
  end

  test "should destroy importador" do
    assert_difference('Importador.count', -1) do
      delete :destroy, id: @importador
    end

    assert_redirected_to importadors_path
  end
end
