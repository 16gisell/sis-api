class AddTipoUsuarioIdToUsuarios < ActiveRecord::Migration[7.1]
  def change
    add_index :usuarios, :tipo_usuario_id

    add_foreign_key :usuarios, :tipo_usuarios, on_delete: :restrict
  end
end
