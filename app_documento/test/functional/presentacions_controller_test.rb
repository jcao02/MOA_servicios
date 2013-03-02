require 'test_helper'

class PresentacionsControllerTest < ActionController::TestCase
  setup do
    @presentacion = presentacions(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:presentacions)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create presentacion" do
    assert_difference('Presentacion.count') do
      post :create, presentacion: { cpe: @presentacion.cpe, empaque: @presentacion.empaque, fecha_vencimiento: @presentacion.fecha_vencimiento, peso_escurrido: @presentacion.peso_escurrido, peso_neto: @presentacion.peso_neto }
    end

    assert_redirected_to presentacion_path(assigns(:presentacion))
  end

  test "should show presentacion" do
    get :show, id: @presentacion
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @presentacion
    assert_response :success
  end

  test "should update presentacion" do
    put :update, id: @presentacion, presentacion: { cpe: @presentacion.cpe, empaque: @presentacion.empaque, fecha_vencimiento: @presentacion.fecha_vencimiento, peso_escurrido: @presentacion.peso_escurrido, peso_neto: @presentacion.peso_neto }
    assert_redirected_to presentacion_path(assigns(:presentacion))
  end

  test "should destroy presentacion" do
    assert_difference('Presentacion.count', -1) do
      delete :destroy, id: @presentacion
    end

    assert_redirected_to presentacions_path
  end
end
