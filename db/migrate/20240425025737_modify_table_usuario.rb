class ModifyTableUsuario < ActiveRecord::Migration[7.1]
  def change
    change_column :usuarios, :numero_documento, :string
  end
end
