require "test_helper"

class Api::V1::TipoDocumentosControllerTest < ActionDispatch::IntegrationTest
  setup do
    @api_v1_tipo_documento = tipo_documentos(:one)
  end

  test "should get index" do
    get api_v1_tipo_documentos_url, as: :json
    assert_response :success
  end

  test "should create api_v1_tipo_documento" do
    assert_difference("TipoDocumento.count") do
      post tipo_documentos_url, params: { tipo_documento: {  } }, as: :json
    end

    assert_response :created
  end

  test "should show api_v1_tipo_documento" do
    get tipo_documento_url(@api_v1_tipo_documento), as: :json
    assert_response :success
  end

  test "should update api_v1_tipo_documento" do
    patch tipo_documento_url(@api_v1_tipo_documento), params: { tipo_documento: {  } }, as: :json
    assert_response :success
  end

  test "should destroy api_v1_tipo_documento" do
    assert_difference("TipoDocumento.count", -1) do
      delete tipo_documento_url(@api_v1_tipo_documento), as: :json
    end

    assert_response :no_content
  end
end
