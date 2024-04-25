require "test_helper"

class Api::V1::TipoUsuariosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_tipo_usuario = tipo_usuarios(:one)
  end

  test "should get index" do
    get api_v1_tipo_usuarios_url, as: :json
    assert_response :success
  end

  test "should create api_v1_tipo_usuario" do
    assert_difference("TipoUsuario.count") do
      post api_v1_tipo_usuarios_url, params: { tipo_usuario: {  } }, as: :json
    end

    assert_response :created
  end

end
