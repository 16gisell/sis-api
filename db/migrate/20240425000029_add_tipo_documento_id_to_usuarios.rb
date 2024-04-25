class AddTipoDocumentoIdToUsuarios < ActiveRecord::Migration[7.1]
  def change
    add_index :usuarios, :tipo_documento_id

    add_foreign_key :usuarios, :tipo_documentos, on_delete: :restrict
  end
end
